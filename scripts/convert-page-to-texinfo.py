#!/usr/bin/env python3
#
# Copyright (C) 2023 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

import enum
import os
import re
import sh
import sys

def usage(progname):
    print ("Usage: {} <path/to/file.md>".format(progname))

class State(enum.Enum):
    NOT_FOUND = 0
    FOUND_TOP_NODE = 1

def fixup_texinfo(input_path):
    output_path = str(sh.mktemp()).replace(os.linesep, '')

    input_texi_file = open(input_path, 'r')
    output_texi_file = open(output_path, 'w')

    state = State.NOT_FOUND

    for line in input_texi_file:
        line = line.replace(os.linesep, '')
        if line == '@node Top':
            state = State.FOUND_TOP_NODE
            output_texi_file.write(line + os.linesep)
        elif state == State.FOUND_TOP_NODE and line.startswith("@top "):
            output_texi_file.write("@top top" + os.linesep)
            output_texi_file.write(os.linesep)
            output_texi_file.write("@subsection {}".format(
                line.split(" ")[1]) + os.linesep)
        else:
            output_texi_file.write(line + os.linesep)

    output_texi_file.close()
    input_texi_file.close()

    sh.mv ("-f", output_path, input_path)

def convert(input_path, output_path):
    sh.pandoc("--from", "markdown",
              "--to", "texinfo",
              input_path,
              "-o", output_path)
    sh.rm("-f", input_path)

if len(sys.argv) != 2:
    usage(sys.argv[0])
    sys.exit(64) # EX_USAGE in sysexits.h

input_path = sys.argv[1]
output_path = re.sub('\.md$', '', input_path) + ".texi"

convert(input_path, output_path)
fixup_texinfo(output_path)
