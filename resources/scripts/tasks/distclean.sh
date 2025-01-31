#!/usr/bin/env bash
#
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

# shellcheck source=resources/scripts/misc/sysexits.sh
topdir="$(dirname "${BASH_SOURCE[0]}")"/../../../
. "${topdir}"/resources/scripts/misc/sysexits.sh

progname="$0"
package="$(basename "$(dirname "${progname}")")"

distclean_usage()
{
    printf "Usage:\n"
    printf "\t%s --help # %s\n" \
           "${progname}" \
           "Print this help"
    printf "\t%s        # remove %s source code.\n" \
           "${progname}" \
           "${package}"
}

distclean_main()
{
    func="$1"
    shift 1
    if [ $# -eq 0 ] ; then
        if [ ! -f projectname ] ; then
            echo "Error: for safety reasons " \
                 "this program can only run in the top directory."
            exit 1
        else
            eval "${func}"
        fi
    elif [ $# -eq 1 ] && [ "$1" = "--help" ] ; then
        distclean_usage "${progname}"
        exit 0
    else
        distclean_usage "${progname}"
        exit "${EX_USAGE}"
    fi
}
