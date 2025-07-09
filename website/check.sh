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

usage()
{
	progname="$1"

	printf "Examples:\n"
	printf "\t%s %s %s\n" \
	       "${progname}" \
	       "--website-prefix software/gnuboot" \
	       "--directory site"
	printf "\t%s %s %s\n" \
	       "${progname}" \
	       "--website-prefix software/gnuboot" \
	       "--tarball website.tar.gz"
	printf "\n"

	printf "Usage:\n"
	printf "\t%s %s\n" "${progname}" "<-h|--help>"
	printf "\t%s %s %s\n" "${progname}" \
	       "--website-prefix PREFIX" "<COMMAND [ARGUMENT]>"
	printf "\n"

	printf "Main commands:\n"
	printf "\t-d, --directory DIRECTORY\n"
	printf "\t\tCheck DIRECTORY\n"
	printf "\t-t, --tarball TARBALL\n"
	printf "\t\tCheck TARBALL\n"
	printf "\n"

	printf "Other options:\n"
	printf "\t-h, --help\n"
	printf "\t\tDisplay this help and exit.\n"
	printf "\n"
}

test_directory_pattern()
{
	name="$1"
	directory="$2"
	pattern="$3"

	find "${directory}" -print0 | sed "s#^${directory}/##" | grep -q "${pattern}"

	result=$?

	if [ ${result} -eq 0 ] ; then
		echo "[ OK ] ${name}"
	else
		echo "[ !! ] ${name} failed"
		exit 1
	fi
}

test_tarball_pattern()
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

run_directory_tests()
{
	directory="$1"
	prefix="$2"

	directory_name="$(basename "${directory}")"

	test_directory_pattern "${directory_name}: index.html present test" \
			       "${directory}" \
			       "${prefix}/index.html"

	test_directory_pattern "${directory_name}: html test" \
			       "${directory}" \
			       "${prefix}/.*\.html$"
}

run_tarball_tests()
{
	tarball="$1"
	prefix="$2"

	filename="$(basename "${tarball}")"
	test_tarball_pattern "${filename}: html test" "${tarball}" '\.html$'
	test_tarball_pattern "${filename}: jpg test" "${tarball}" '\.jpg$'
}

# shellcheck disable=SC2166 # We want to make operator precedence
# clear.
if [ $# -eq 1 ] && [ "$1" = "-h" -o "$1" == "--help" ] ; then
	usage "check.sh"
	exit 0
elif [ $# -eq 4 ] && [ "$1" = "--website-prefix" ] ; then
	prefix="$2"
	if [ "$3" = "-d" -o "$3" = "--directory" ] ; then
		directory="$(realpath "$4")"
		run_directory_tests "${directory}" "${prefix}"
	elif [ "$3" = "-t" -o "$3" = "--tarball" ] ; then
		tarball="$(realpath "$4")"
		run_tarball_tests "${tarball}" "${prefix}"
	else
		usage "check.sh"
		exit ${EX_USAGE}
	fi
else
	usage "check.sh"
	exit ${EX_USAGE}
fi
