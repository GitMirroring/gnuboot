#!/usr/bin/env bash
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

tarball=""

help()
{
	echo "Usage: $0 [options]"
	echo ""
	echo "Available options:"
	echo -e "\t-h, --help"
	echo -e "\t\tDisplay this help and exit."
	echo -e "\t-t, --tarball TARBALL"
	echo -e "\t\tCheck TARBALL\n"
}

test_pattern()
{
	name="$1"
	tarball="$2"
	pattern="$3"

	tar tf "${tarball}" | grep -q "${pattern}"

	result=$?

	if [ ${result} -eq 0 ] ; then
		echo "[ OK ] ${name}"
	else
		echo "[ !! ] ${name} failed"
		exit 1
	fi
}

test_savannah_cvs_constraints()
{
	name="$1"
	tarball="$2"

	nr_files=$(tar tf "${tarball}" | grep -c -v '/')

	if [ "${nr_files}" = "1" ] ; then
		echo "[ OK ] ${name}"
	else
		echo "[ !! ] ${name} failed"
		exit 1
	fi
}


run_tests()
{
	test_pattern "html test" "${tarball}" '\.html$'
	test_pattern "jpg test" "${tarball}" '\.jpg$'
	test_savannah_cvs_constraints "Savannah CVS: Only /index.html in root directory" \
				      "${tarball}"
}

if [ $# -eq 1 ] && [ "$1" = "-h" -o "$1" == "--help" ] ; then
	help
	exit 0
elif [ $# -eq 2 ] && [ "$1" = "-t" -o "$1" = "--tarball" ] ; then
	tarball="$(realpath $2)"
	run_tests "${tarball}"
else
	help
	exit ${EX_USAGE}
fi
