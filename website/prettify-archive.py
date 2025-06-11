#!/usr/bin/env python3
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
import io
import sys
import tarfile

from bs4 import BeautifulSoup

input_tarball  = tarfile.open(sys.argv[1])
output_tarball = tarfile.open(sys.argv[2], 'w')

for elm in input_tarball:
    if elm.isfile() and elm.name.endswith(".html"):
        # Prettify the HTML. Not only this is more readable but it should
        # normally also be reproducible, so functionally equivalent HTML like
        # <div foo="1" bar="2"> and <div foo="2" bar="1"> should produce the
        # exact same prettified HTML.
        content = input_tarball.extractfile(elm).read()
        soup = BeautifulSoup(content, 'html.parser')
        data = bytes(soup.prettify(), 'utf-8')
        elm.size = len(data)
        memfd = io.BytesIO(data)
        output_tarball.addfile(elm, memfd)
    else:
        output_tarball.addfile(elm, input_tarball.extractfile(elm))

input_tarball.close()
output_tarball.close()
