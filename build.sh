#!/bin/sh
# Copyright (C) 2022-2023 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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

# For compatibility with sysexits.h (see man 3 sysexits.h for more details)
EX_USAGE=64

lbwww_uri="https://git.sr.ht/~libreboot/lbwww"
lbwww_path=""

help()
{
	echo "Usage: $0 [options]"
	echo ""
	echo "Available options:"
	echo -e "\t-h, --help"
	echo -e "\t\tDisplay this help and exit."
	echo -e "\t--with-lbwww-path PATH"
	echo -e "\t\tUse a local lbwww directory from PATH\n" \
	     "\t\tinstead of downloading the latest version from\n" \
	     "\t\t${lbwww_uri}"
}

if [ $# -eq 1 ] && [ "$1" = "-h" -o "$1" == "--help" ] ; then
	help
	exit 0
elif [ $# -eq 2 ] && [ "$1" = "--with-lbwww-path" ] ; then
	lbwww_path="$(realpath $2)"
elif [ $# -ne 0 ] ; then
	help
	exit ${EX_USAGE}
fi

set -e

if [ ! -d untitled ] ; then
	git clone https://git.sr.ht/~libreboot/untitled
else
	git -C untitled clean -dfx
	git -C untitled pull --rebase
fi

cd untitled  && mkdir -p www && cd www

if [ -z "${lbwww_path}" ] && [ ! -d lbwww ] ; then
	git clone "${lbwww_uri}"
elif [ ! -d lbwww ] ; then
	cp -a "${lbwww_path}" lbwww
elif [ -z "${lbwww_path}" ] ; then
	git -C lbwww remote set-url origin "${lbwww_uri}"
	git -C lbwww clean -dfx
	git -C lbwww pull --rebase
else
	rm -rf lbwww
	cp -a "${lbwww_path}" lbwww
fi

if [ ! -d lbwww-img ] ; then
	git clone https://git.sr.ht/~libreboot/lbwww-img
else
	git -C lbwww-img clean -dfx
	git -C lbwww-img pull --rebase
fi

cd ../

./build sites lbwww
