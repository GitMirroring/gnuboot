#!/usr/bin/env bash
#
# Copyright (C) 2023 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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

printf "+-----------------------+\n"
printf "| Running targets test: |\n"
printf "+-----------------------+\n"

errors=0

report()
{
    ret=$?
    target="$1"

    if [ ${ret} -ne 0 ] ; then
	echo "[ OK ] ./build boot roms list: ${target} target not found."
    else
	errors=$(expr ${errors} + 1)
	echo "[ !! ] ./build boot roms list: found ${target} target."
    fi
}

for target in default fam15h_rdimm fam15h_udimm ; do
    ./build boot roms list | grep "^${target}\$" 2>&1 >/dev/null; \
	report "${target}"
done

if [ ${errors} -gt 0 ] ; then
    exit 1
fi
