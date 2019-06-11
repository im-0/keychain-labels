/*
 *  Parametric 3D printed keychain labels.
 *  Copyright (C) 2019  Ivan Mironov <mironov.ivan@gmail.com>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

use <./libfontmetrics.scad>

// Overlap, used for geometry addition.
_OA = 0.001;  // mm
// Overlap, used for geometry subtraction.
_OS = 1.0;  // mm


function _chamfer_size(height) = 2.0 / 3.0 * height;

function _depth(usable_depth, chamfer_size) = usable_depth + chamfer_size * 2.0;

function _width(usable_width, usable_depth, chamfer_size) =
	usable_width + usable_depth + chamfer_size * 2.0;

module _base_plate_2d(usable_width, usable_depth)
{
	circle_off = usable_width / 2.0;

	hull() {
		for (i = [-1.0, 1.0]) {
			translate([circle_off * i, 0.0, 0.0])
				circle(d=usable_depth, $fn=128);
		}
	}
}

module _base_plate(usable_width, usable_depth, height, hole_d)
{
	chamfer_size = _chamfer_size(height);
	hole_off = (usable_width + usable_depth / 2.0) / 2.0;

	echo(real_width=_width(usable_width, usable_depth, chamfer_size));
	echo(real_depth=_depth(usable_depth, chamfer_size));

	assert(hole_d < usable_depth / 2.0);

	difference() {
		minkowski() {
			linear_extrude(height=height - chamfer_size)
				_base_plate_2d(usable_width, usable_depth);
			cylinder(r1=chamfer_size, r2=0, h=chamfer_size);
		}

		for (i = [-1.0, 1.0]) {
			translate([hole_off * i, 0.0, -_OS])
				cylinder(d=hole_d, h=height + _OS * 2.0, $fn = 64);
		}
	}
}

module _text(
	usable_width, usable_depth, txt_height,
	txt, txt_font, txt_font_size, txt_halign)
{
	txt_m = measureWrappedTextBounds(
			txt,
			font=txt_font,
			size=txt_font_size,
			width=usable_width,
			halign=txt_halign);
	txt_x_off =
		txt_halign == "left" ?
			-usable_width / 2.0 :
		txt_halign == "center" ?
			0.0 :
		txt_halign == "right" ?
			usable_width / 2.0 :
		undef;
	txt_depth = txt_m[1].y;
	txt_y_off = -txt_m[0].y - txt_depth / 2.0;

	assert(!is_undef(txt_x_off));
	assert(txt_depth < usable_depth);

	translate([txt_x_off, txt_y_off, 0.0]) {
		// There is no way to calculate exact convexity, so glitches
		// are imminent in the preview.
		linear_extrude(height=txt_height, convexity=2)
			drawWrappedText(txt,
					font=txt_font,
					size=txt_font_size,
					width=usable_width,
					halign=txt_halign,
					$fn=64);
	}
}

module embossed_label(
	usable_width, usable_depth, height, hole_d,
	txt_height, txt, txt_font, txt_font_size,
	txt_halign)
{
	base_h = height - txt_height;

	assert(base_h > 0.0);

	_base_plate(usable_width, usable_depth, base_h, hole_d);

	translate([0.0, 0.0, base_h - _OA])
		_text(
				usable_width,
				usable_depth,
				txt_height + _OA,
				txt,
				txt_font,
				txt_font_size,
				txt_halign);
}

module engraved_label(
	usable_width, usable_depth, height, hole_d,
	txt_height, txt, txt_font, txt_font_size,
	txt_halign)
{
	assert(txt_height < height);

	difference() {
		_base_plate(usable_width, usable_depth, height, hole_d);

		translate([0.0, 0.0, height - txt_height])
			_text(
					usable_width,
					usable_depth,
					txt_height + _OS,
					txt,
					txt_font,
					txt_font_size,
					txt_halign);
	}
}

module stencil_label(
	usable_width, usable_depth, height, hole_d,
	txt, txt_font, txt_font_size,
	txt_halign)
{
	difference() {
		_base_plate(usable_width, usable_depth, height, hole_d);

		translate([0.0, 0.0, -_OS])
			_text(
					usable_width,
					usable_depth,
					height + _OS * 2.0,
					txt,
					txt_font,
					txt_font_size,
					txt_halign);
	}
}


module label(
	usable_width, usable_depth, height, hole_d,
	txt, style, txt_halign,
	embossed_txt_height, embossed_txt_font, embossed_txt_font_size,
	engraved_txt_height, engraved_txt_font, engraved_txt_font_size,
	stencil_txt_font, stencil_txt_font_size)
{
	if (style == "embossed") {
		embossed_label(
				usable_width, usable_depth, height, hole_d,
				embossed_txt_height,
				txt,
				embossed_txt_font,
				embossed_txt_font_size,
				txt_halign);
	} else if (style == "engraved") {
		engraved_label(
				usable_width, usable_depth, height, hole_d,
				engraved_txt_height,
				txt,
				engraved_txt_font,
				engraved_txt_font_size,
				txt_halign);
	} else if (style == "stencil") {
		stencil_label(
				usable_width, usable_depth, height, hole_d,
				txt,
				stencil_txt_font,
				stencil_txt_font_size,
				txt_halign);
	} else {
		echo(style=style);
		assert(false, "Unknown label style");
	}
}

function _labels_y_off(txt_style_list, usable_depth, height, r=[]) =
		let(
			chamfer_size = _chamfer_size(height),
			depth = _depth(usable_depth, chamfer_size),
			pos = len(r),
			num = len(txt_style_list),
			spc = 10.0
		) pos < num ? _labels_y_off(txt_style_list, usable_depth, height,
			concat(r, [[
				txt_style_list[pos][0],
				txt_style_list[pos][1],
				((num - 1) / 2.0 - pos) * (depth + spc),
			]])
		) : r;

module labels(
	usable_width, usable_depth, height, hole_d,
	txt_style_list, txt_halign,
	embossed_txt_height, embossed_txt_font, embossed_txt_font_size,
	engraved_txt_height, engraved_txt_font, engraved_txt_font_size,
	stencil_txt_font, stencil_txt_font_size)
{
	assert(len(txt_style_list) > 0);

	for (txt_style_off = _labels_y_off(txt_style_list, usable_depth, height))
		translate([0.0, txt_style_off[2], 0.0])
			label(
					usable_width, usable_depth, height, hole_d,
					txt_style_off[0], txt_style_off[1],
					txt_halign,
					embossed_txt_height,
					embossed_txt_font,
					embossed_txt_font_size,
					engraved_txt_height,
					engraved_txt_font,
					engraved_txt_font_size,
					stencil_txt_font,
					stencil_txt_font_size);
}
