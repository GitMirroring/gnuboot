#!/usr/bin/env bash
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

. "$(dirname "$0")"/resources/scripts/misc/sysexits.sh

GUIX_REVISION="8e2f32cee982d42a79e53fc1e9aa7b8ff0514714"

usage()
{
    progname="$1"

    printf "Usage: %s [options]\n" "${progname}"
    printf "   or: %s print-variable GUIX_REVISION\n" "${progname}"
    printf "\n"
    printf "Available options:\n"
    printf "\t-h, --help\n"
    printf "\t\tDisplay this help and exit.\n"
}

progname="guix-revision.sh"

if [ $# -eq 1 ] && [ "$1" = "--help" ] ; then
    usage "${progname}"
    exit "${EX_OK}"
elif [ $# -eq 1 ] && [ "$1" = "-h" ] ; then
    usage "${progname}"
    exit "${EX_OK}"
elif [ $# -eq 2 ] && [ "$1" = "print-variable" ] ; then
    if [ "$2" = "GUIX_REVISION" ] ; then
        echo "${GUIX_REVISION}"
    else
        usage "${progname}"
        exit "${EX_USAGE}"
    fi
else
    usage "${progname}"
    exit "${EX_USAGE}"
fi
