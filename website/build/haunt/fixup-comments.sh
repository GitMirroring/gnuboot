#!/usr/bin/env sh
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

set -e

usage()
{
	progname="$1"

	echo "${progname} [path/to/file.html]"
	exit 1
}

if [ $# -ne 1 ] ; then
	usage "fixup-comments.sh"
fi

html_file="$1"

# We need the exact same comments at the exact same place than with
# lbssg to minimize the diff and facilitate the review.
sed -i \
    's#<!-- class="menu"></!-->#<!-- class="menu" -->#g' \
    "${html_file}"
