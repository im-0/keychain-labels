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

use <./kllibs/libkeychain-labels.scad>

WIDTH = 30.0;
DEPTH = 20.0;
HEIGHT = 3.0;
HOLE_DIAMETER = 7.0;

TEXT_HORIZONTAL_ALIGNMENT_1 = "left";
TEXT_HORIZONTAL_ALIGNMENT_2 = "center";
TEXT_HORIZONTAL_ALIGNMENT_3 = "right";

EMBOSSED_TEXT_HEIGHT = 1.0;
EMBOSSED_FONT = "Liberation Sans:style=Bold";
EMBOSSED_FONT_SIZE = 7.0;

ENGRAVED_TEXT_HEIGHT = 1.5;
ENGRAVED_FONT = "Liberation Sans:style=Bold";
ENGRAVED_FONT_SIZE = 7.0;

STENCIL_FONT = "USSR STENCIL:style=Regular";
STENCIL_FONT_SIZE = 7.0;

LABELS = [
	["Room 10", "embossed"],
	["221b",    "embossed"],
	["Room 10", "engraved"],
	["221b",    "engraved"],
	["Room 10", "stencil"],
	["221b",    "stencil"],
];

translate([-60.0, 0.0, 0.0])
	labels(
		WIDTH, DEPTH, HEIGHT, HOLE_DIAMETER,
		LABELS,
		TEXT_HORIZONTAL_ALIGNMENT_1,
		EMBOSSED_TEXT_HEIGHT, EMBOSSED_FONT, EMBOSSED_FONT_SIZE,
		ENGRAVED_TEXT_HEIGHT, ENGRAVED_FONT, ENGRAVED_FONT_SIZE,
		STENCIL_FONT, STENCIL_FONT_SIZE);

labels(
	WIDTH, DEPTH, HEIGHT, HOLE_DIAMETER,
	LABELS,
	TEXT_HORIZONTAL_ALIGNMENT_2,
	EMBOSSED_TEXT_HEIGHT, EMBOSSED_FONT, EMBOSSED_FONT_SIZE,
	ENGRAVED_TEXT_HEIGHT, ENGRAVED_FONT, ENGRAVED_FONT_SIZE,
	STENCIL_FONT, STENCIL_FONT_SIZE);

translate([60.0, 0.0, 0.0])
	labels(
		WIDTH, DEPTH, HEIGHT, HOLE_DIAMETER,
		LABELS,
		TEXT_HORIZONTAL_ALIGNMENT_3,
		EMBOSSED_TEXT_HEIGHT, EMBOSSED_FONT, EMBOSSED_FONT_SIZE,
		ENGRAVED_TEXT_HEIGHT, ENGRAVED_FONT, ENGRAVED_FONT_SIZE,
		STENCIL_FONT, STENCIL_FONT_SIZE);
