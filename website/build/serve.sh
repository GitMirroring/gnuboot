#!/usr/bin/env sh
# Copyright (C) 2022-2024 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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

# cvs -z3 -d:pserver:anonymous@cvs.savannah.gnu.org:/sources/www co www
# cvs -z3 -d:pserver:anonymous@cvs.savannah.gnu.org:/sources/www/symlinks co symlinks/symlinks

set -e

usage()
{
	progname="$1"

	echo "${progname} --website-prefix PREFIX <path/to/tarball> [PORT]"
	exit 1
}

if [ $# -ne 3 ] && [ $# -ne 4 ] && [ "$1" != "--website-prefix" ] ; then
	usage "serve.sh"
fi

basedir="$(dirname $(dirname "$(realpath "$0")"))"

prefix="$2"
tarball="$3"

lighttpd_port=8086
if [ "$#" -eq 4 ] ; then
    lighttpd_port="$4"
fi

mkdir -p "site/${prefix}"
tar xf "${tarball}" -C "site/${prefix}"

# Generate symlinks
perl \
    site/"${prefix}"/web-symlinks/web-symlinks \
    --top "${PWD}"/site/"${prefix}"

# Generate lighttpd.conf
sed -e "s#LIGHTTPD_PORT#${lighttpd_port}#g" \
    "${basedir}/build/lighttpd.conf.tmpl" > \
    "${basedir}/build/lighttpd.conf"

lighttpd -f ${basedir}/build/lighttpd.conf -D
