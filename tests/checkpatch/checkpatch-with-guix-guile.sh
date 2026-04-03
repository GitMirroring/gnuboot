#!/usr/bin/env bash
#
# Copyright (C) 2023-2026 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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
set -o pipefail

topdir="$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")"

fail()
{
    # shellcheck disable=SC2124
    message="$@"

    printf "[ !! ] scripts/checkpatch.scm test failed: %s\n" \
           "${message}"

    exit 1
}

print_banner_line()
{
    nr_characters="$1"
    for i in $(seq 1 "${nr_characters}") ; do
        if [ "${i}" -eq 1 ] || [ "${i}" -eq "${nr_characters}" ] ; then
            printf "+"
        else
            printf "-"
        fi
    done
    printf "\n"
}

print_banner()
{
    guile_version="$1"

    text="$(printf "| Running scripts/checkpatch.scm test with guile %s: |\n" \
                   "${guile_version}")"

    columns=$(echo -n "$text" | wc -c)

    print_banner_line "${columns}"
    echo "${text}"
    print_banner_line "${columns}"
}

test_with_guile()
{
    guile_version="$1"
    print_banner "${guile_version}"

    prefix="$("${topdir}"/resources/wrapper/guix \
               build \
               -s i686-linux \
               guile@"${guile_version}" | grep -v '\-debug$')"

    export PATH="${prefix}/bin/:${PATH}"

    "${topdir}"/tests/checkpatch/checkpatch.sh

    printf "+--------------------+\n"
    printf "| Running tests done |\n"
    printf "+--------------------+\n"
}

# TODO: modify checkpatch.scm to also warn if this isn't updated when
# the guix revision is updated.

# +-----------------------+-------------+---------+---------+
# | Distribution          | package     | Guile   | Default |
# |                       |             | version |         |
# |                       |             |         |         |
# +-----------------------+-------------+---------+---------+
# | Guix 1.5.0 linux-i686 | guile-1.8   | 1.8.8   | No      |
# +-----------------------+-------------+---------+---------+
# | Trisquel 10 (nabia)   | guile-2.0   | 2.0.13  | No [1]  |
# +-----------------------+-------------+---------+---------+
# | Guix 1.5.0 linux-i686 | guile-2.0   | 2.0.14  | No      |
# +-----------------------+-------------+---------+---------+
# | Guix 1.5.0 linux-i686 | guile-2.2.4 | 2.2.4   | No      |
# +-----------------------+-------------+---------+---------+
# | PureOS 10 (byzantium) | guile-2.2   | 2.2.7   | No [1]  |
# +-----------------------+-------------+---------+---------+
# | Guix 1.5.0 linux-i686 | guile-2.2   | 2.2.7   | No      |
# +-----------------------+-------------+---------+---------+
# | PureOS 11 (crimson)   | guile-2.2   | 2.2.7   | No [1]  |
# +-----------------------+-------------+---------+---------+
# | Trisquel 12 (ecne)    | guile-2.2   | 2.2.7   | No [1]  |
# +-----------------------+-------------+---------+---------+
# | Trisquel 11 (aramo)   | guile-2.2   | 2.2.7   | No [1]  |
# +-----------------------+-------------+---------+---------+
# | Trisquel 10 (nabia)   | guile-2.2   | 2.2.7   | No [1]  |
# +-----------------------+-------------+---------+---------+
# | Trisquel 10 (nabia)   | guile-3.0   | 3.0.1   | No [1]  |
# +-----------------------+-------------+---------+---------+
# | PureOS 10 (byzantium) | guile-3.0   | 3.0.5   | No [1]  |
# +-----------------------+-------------+---------+---------+
# | Trisquel 11 (aramo)   | guile-3.0   | 3.0.7   | No [1]  |
# +-----------------------+-------------+---------+---------+
# | PureOS 11 (crimson)   | guile-3.0   | 3.0.8   | No [1]  |
# +-----------------------+-------------+---------+---------+
# | Guix 1.5.0 linux-i686 | guile-3.0   | 3.0.9   | Yes     |
# +-----------------------+-------------+---------+---------+
# | Trisquel 12 (ecne)    | guile-3.0   | 3.0.9   | No [1]  |
# +-----------------------+-------------+---------+---------+
# | Guix 1.5.0 linux-i686 | guile-next  | 3.0.10  | No      |
# +-----------------------+-------------+---------+---------+
# [1] The distribution has no default guile version so the user need
#     to choose at the installation time which version to use.
#
# So far we only validated PureOS 10 (byzantium), Trisquel 10
# (nabia) and 11 (aramo) and the oldest most recent Guile version
# between all of them is 3.0.5 so we could use that as the minimum
# version of Guile to test against. Unfortunately Guix 1.5.0 has 2.2.7
# and 3.0.9 but not 3.0.5.
#
# So we can use guile 2.2.7 as minimum version as it is available in
# most distributions, including Guix 1.5.0.

# This revision is included in:
# - Guix 1.5.0 with the guile-2.2 package
# - PureOS 10 (byzantium) with the guile-2.2 package
# - Trisquel 10 (aramo) with the guile-2.2 package
test_with_guile "2.2.7"
