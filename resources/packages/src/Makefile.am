# GNU Boot --- Boot software distribution
#
# Copyright © 2023-2026 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
#
# This file is part of GNU Boot.
#
# This file is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or (at
# your option) any later version.
#
# This file is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

# TODO: Use Guix to produce a source package to make it reproducible
release/guix_transitive_sources.tar:  Makefile
	install -d release
	tar cf $@ \
		`$(TOPDIR)/resources/wrapper/guix build \
		--system=i686-linux \
		--sources=transitive \
		$(GUIX_PACKAGE_NAMES) grub-coreboot | sort -u`

guix-transitive-sources-help:
	@printf "\t%s %s\n" \
		"make release/guix_transitive_sources.tar.xz #" \
		"Relase the source code corresponding to the package binaries."
