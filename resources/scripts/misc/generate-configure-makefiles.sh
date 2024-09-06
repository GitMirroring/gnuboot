#!/usr/bin/env bash
#
# Copyright (C) 2024 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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

topdir="$(dirname "$(dirname "$(dirname "$(dirname "$0")")")")"

# The resources/packages/src/release script is used to released the
# GNU Boot source code in a directory like gnuboot-0.1-rc3-100-g01abcef_src
# inside the release/ directory.
#
# To do that it copies the built source code of various projects like
# coreboot, grub, etc inside  release/gnuboot-0.1-rc3-100-g01abcef_src.
#
# To remove the binaries and keep only the source, it then copies the
# topdir build script inside that directory as well and then run
# './build clean all'.
#
# Since we're in release/gnuboot-0.1-rc3-100-g01abcef_src and that the
# full GNU Boot source code wasn't copied, it doesn't find autogen.sh
# when it runs that as the ./build script requires it through the
# sourcing of resources/scripts/misc/generate-configure-makefiles.sh.
#
# We could fix that by copying the right files on the target directory
# but since we're already removing files, it's better to just skip the
# regeneration of GNU Boot Makefiles completely.
if [ ! -f "${topdir}"/configure.ac ] ; then
    exit 0
fi

if [ ! -f configure ] || \
       [ ! -f Makefile ] || \
       [ ! -f resources/packages/i945-thinkpads-install-utilities/Makefile ] ; then
    ./autogen.sh
    ./configure
fi
