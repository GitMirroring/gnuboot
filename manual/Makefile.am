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
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
info_TEXINFOS = gnuboot.texi

# This also contains the pictures dependencies and other files as well
# as no other workaround documented in the "9.4.1 Built Sources
# Example" node of the automake work for this case (we don't want to
# type make all before building the various document formats).
gnuboot_TEXINFOS = \
	build-guix-i686-linux.sh \
	build-guix-x86_64-linux.sh \
	fdl-1.3.texi \
	guix-i686-linux.scm \
	guix-revision.texi \
	guix-x86_64-linux.scm \
	images/SOIC-16.eps \
	images/SOIC-16.png

CLEANFILES = \
	build-guix-i686-linux.sh \
	build-guix-x86_64-linux.sh \
	guix-i686-linux.scm \
	guix-revision.texi \
	guix-x86_64-linux.scm \
	images/SOIC-16.eps \
	images/SOIC-16.png

infoimagedir = $(infodir)/images
dist_infoimage_DATA = \
	images/SOIC-16.eps \
	images/SOIC-16.png

# Inspired from guix 1.3.0 docs/local.mk
.jpeg.png:
	gm convert "$<" "$(srcdir)/$@"
.jpeg.eps:
	gm convert "$<" "$(srcdir)/$@"

build-guix-%-linux.sh: build-guix-%-linux.sh.in
	m4 -DGUIX_REVISION=$(GUIX_REVISION) $^ | \
		sed 's/#.*//' | \
		sed '/^$$/d' > $@
	chmod +x $@

guix-revision.texi:
	../$(srcdir)/guix-revision.sh print-texinfo > $@
