# Copyright (C) 2025 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

DEBIAN_FILES = \
	debian/changelog \
	debian/control \
	debian/copyright \
	debian/rules \
	debian/source/format

.PHONY: debian
debian: $(DEBIAN_FILES)
	dpkg-buildpackage -us -uc

debian-clean:
	rm -f $(DEBIAN_FILES)

debian/changelog: resources/debian/changelog
	mkdir -p `dirname $@`
	install $^ $@

debian/control: resources/debian/control
	mkdir -p `dirname $@`
	install $^ $@

debian/copyright: resources/debian/copyright
	mkdir -p `dirname $@`
	install $^ $@

debian/rules: resources/debian/rules
	mkdir -p `dirname $@`
	install $^ $@

debian/source/format: resources/debian/source/format
	mkdir -p `dirname $@`
	install $^ $@
