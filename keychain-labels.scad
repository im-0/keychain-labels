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

TEXT_HORIZONTAL_ALIGNMENT = "center";

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
	["Room 10", "engraved"],
	["Room 10", "stencil"],
];

labels(
	WIDTH, DEPTH, HEIGHT, HOLE_DIAMETER,
	LABELS,
	TEXT_HORIZONTAL_ALIGNMENT,
	EMBOSSED_TEXT_HEIGHT, EMBOSSED_FONT, EMBOSSED_FONT_SIZE,
	ENGRAVED_TEXT_HEIGHT, ENGRAVED_FONT, ENGRAVED_FONT_SIZE,
	STENCIL_FONT, STENCIL_FONT_SIZE);
