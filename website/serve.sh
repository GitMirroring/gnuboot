#!/usr/bin/env sh
# Copyright (C) 2022 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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
	echo "$0 [PORT]"
	exit 1
}

if [ $# -ne 0 ] && [ $# -ne 1 ] ; then
	usage
fi

basedir="$(dirname $(realpath $0))"

lighttpd_port=8086
if [ $# -eq 1 ] ; then
    lighttpd_port="$1"
fi

mkdir -p "site/${prefix}"
tar xf "${tarball}" -C "site/${prefix}"

sed -e "s#LIGHTTPD_PORT#${lighttpd_port}#g" \
    -e "s#LIGHTTPD_PORT#${lighttpd_port}#g" \
    "${basedir}/lighttpd.conf.tmpl" > \
    "${basedir}/lighttpd.conf"

lighttpd -f lighttpd.conf -D
