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
set -e

topdir="$(dirname "$(dirname "$(realpath "$0")")")"

. "${topdir}"/resources/scripts/misc/sysexits.sh

####################
# Various settings #
####################

# Retrived from the old background1024x768.png background1280x800.png
# in resources/grub/background
background_color="#262626"

base_image="${topdir}"/artwork/gnuboot_logo_dark.svg

# The ratio 0.375 was chosen because the resulting logo size (within
# the background) was close enough to the the size in the original
# background files. It may or may not be possible to do better. The
# exact size isn't important, however having resolutions that divide
# fine to a positive integer is something good to have. And making the
# GRUB menu entries unreadable because they mix too much with the logo
# is something to avoid.
logo_scale_ratio_numerator=450
logo_scale_ratio_denominator=1000

usage()
{
        printf "Usage: %s <-h|--help>\n" "${progname}"
        printf "   Or: %s generate <hres> <vres> <filename>\n" \
               "${progname}"
}

scale_to_height()
{
    input="$1"
    output="$2"
    height="$3"

    rsvg-convert \
        --height "${height}" \
        --keep-aspect-ratio \
        --background-color "${background_color}" \
        "${input}" -o "${output}"
}

generate_picture()
{
    hres="$1"
    vres="$2"
    filename="$3"

    scale_to_height \
        "${base_image}" \
        "${filename}".scaled_"${vres}".png \
        "${vres}"

    thumbnail_vres="$(( vres \
                            * \
                            logo_scale_ratio_numerator \
                        / \
                        logo_scale_ratio_denominator))"

    scaled_hres="$(gm identify \
                       "${filename}".scaled_"${vres}".png \
                      -format "%w")"

    thumbnail_hres="$((scaled_hres \
                            * \
                            logo_scale_ratio_numerator \
                        / \
                        logo_scale_ratio_denominator))"

    gm convert "${filename}".scaled_"${vres}".png \
       -thumbnail "${thumbnail_hres}"x"${thumbnail_vres}" \
       -background "${background_color}" \
       -gravity center \
       -extent "${hres}"x"${vres}" "${filename}"
}

progname="generate-background-picture.sh"

if [ $# -eq 1 ] && [ "$1" = "--help" ] ; then
    usage "${progname}"
    exit "${EX_OK}"
elif [ $# -eq 1 ] && [ "$1" = "-h" ] ; then
    usage "${progname}"
    exit "${EX_OK}"
elif [ $# -eq 4 ] && [ "$1" = "generate" ] ; then
    generate_picture "$2" "$3" "$4"
else
    usage "${progname}"
    exit "${EX_USAGE}"
fi
