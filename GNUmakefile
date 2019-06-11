# Parametric 3D printed keychain labels.
# Copyright (C) 2019  Ivan Mironov <mironov.ivan@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

$(RM) ?= rm
CP ?= cp
PYTHON ?= python

OPENSCAD ?= openscad

.PHONY: help
help:
	@echo "Usage:"
	@echo "    make help"
	@echo "        Print this help message"
	@echo "    make clean"
	@echo "        Remove all generated files"
	@echo "    make all"
	@echo "        Generate STL file"

.PHONY: clean
clean:
	$(RM) --verbose --recursive ./out/*.stl

out/%.stl: %.scad
	$(OPENSCAD) \
		--hardwarnings \
		-o "$(@)" \
		"$(<)"
	$(PYTHON) "./c14n_stl" "$(@)"

.PHONY: all
all: out/keychain-labels.stl

example.stl: out/keychain-labels.example.stl
	$(CP) --verbose $(^) "./example.stl"

.PHONY: example
example: example.stl
