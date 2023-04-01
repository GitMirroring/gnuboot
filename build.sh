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

lbwww_img_uri="https://git.sr.ht/~libreboot/lbwww-img"
lbwww_img_path=""

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
	echo -e "\t--with-lbwww-img-path PATH"
	echo -e "\t\tUse a local lbwww-img directory from PATH\n" \
	     "\t\tinstead of downloading the latest version from\n" \
	     "\t\t${lbwww_img_uri}"
}

sync_repo()
{
	dst_path="$1"
	src_uri="$2"
	src_path="$3"

	if [ -z "${src_path}" ] && [ ! -d "${dst_path}" ] ; then
		git clone "${src_uri}" "${dst_path}"
	elif [ ! -d "${dst_path}" ] ; then
		mkdir -p "$(dirname ${dst_path})"
		cp -a "${src_path}" "${dst_path}"
	elif [ -z "${src_path}" ] ; then
		git -C "${dst_path}" remote set-url origin "${src_uri}"
		git -C "${dst_path}" clean -dfx
		git -C "${dst_path}" pull --rebase
	else
		rm -rf "${dst_path}"
		cp -a "${src_path}" "${dst_path}"
	fi
}

if [ $# -eq 1 ] && [ "$1" = "-h" -o "$1" == "--help" ] ; then
	help
	exit 0
elif [ $# -eq 2 ] && [ "$1" = "--with-lbwww-path" ] ; then
	lbwww_path="$(realpath $2)"
elif [ $# -eq 2 ] && [ "$1" = "--with-lbwww-img-path" ] ; then
	lbwww_img_path="$(realpath $2)"
elif [ $# -eq 4 ] && [ "$1" = "--with-lbwww-path" ]  && \
	 [ "$3" = "--with-lbwww-img-path" ] ; then
	lbwww_path="$(realpath $2)"
	lbwww_img_path="$(realpath $4)"
elif [ $# -eq 4 ] && [ "$1" = "--with-lbwww-img-path" ] && \
	 [ "$3" = "--with-lbwww-path" ] ; then
	lbwww_img_path="$(realpath $2)"
	lbwww_path="$(realpath $4)"
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

sync_repo "untitled/www/lbwww" "${lbwww_uri}" "${lbwww_path}"
sync_repo "untitled/www/lbwww-img" "${lbwww_img_uri}" "${lbwww_img_path}"

cd untitled
./build sites lbwww
