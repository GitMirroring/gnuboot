#!/usr/bin/env python3
#
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

import os
import sys

def usage():
    print("Usage: status.py [en|es]")

config = {
    'GNU_BOOT_0.1_RC6_STATUS_TABLE' : 'status/0.1-rc6',
    'GNU_BOOT_0.1_RC5_STATUS_TABLE' : 'status/0.1-rc5',
    'GNU_BOOT_0.1_RC4_STATUS_TABLE' : 'status/0.1-rc4',
    'GNU_BOOT_0.1_RC3_STATUS_TABLE' : 'status/0.1-rc3',
    'GNU_BOOT_0.1_RC2_STATUS_TABLE' : 'status/0.1-rc2',
    'GNU_BOOT_0.1_RC1_STATUS_TABLE' : 'status/0.1-rc1',
    'COREBOOT_UPSTREAM_STATUS' : 'status/coreboot-upstream-status',
    'UPSTREAM_VERSIONS' : 'status/upstream-versions',
    'REPRODUCIBLE_BUILDS_STATUS' : 'status/reproducible-builds-status',
}

if len(sys.argv) != 2:
    usage()
    sys.exit(os.EX_USAGE)

lang = sys.argv[1]
status = None
extension = None

if lang == 'en':
    status = open('status/status.md.tmpl', 'r')
    extension = '.md'
else:
    status = open('status/status.{}.md.tmpl'.format(lang), 'r')
    extension = '.es.md'

for line in status:
    line = line.replace('\n', '')
    if line in config.keys():
        replacement = open(config.get(line) + extension, 'r')
        print(replacement.read(), end='')
    else:
        print(line)

