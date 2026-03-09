# Copyright (C) 2026 Denis 'GNUtoo' Carikli <GNUtoo@cybersimension.org>
#
# This file is part of GNU Boot.
#
# GNU Boot is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or (at
# your option) any later version.
#
# GNU Boot is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Boot.  If not, see <http://www.gnu.org/licenses/>.

SENTINEL =

data_DATA = \
	ich9fdgbe_4m.bin \
	ich9fdgbe_8m.bin \
	ich9fdgbe_16m.bin \
	ich9fdgbe_4m_ro.bin \
	ich9fdgbe_8m_ro.bin \
	ich9fdgbe_16m_ro.bin \
	ich9fdnogbe_4m.bin \
	ich9fdnogbe_8m.bin \
	ich9fdnogbe_16m.bin \
	ich9fdnogbe_4m_ro.bin \
	ich9fdnogbe_8m_ro.bin \
	ich9fdnogbe_16m_ro.bin \
	$(SENTINEL)

%_ifd.bin : %_ifd.set ich9_ifd.spec
	bincfg ich9_ifd.spec $< $@

ich9_gbe.bin : ich9_gbe.set ich9_ifd.spec
	bincfg ich9_gbe.spec $< $@

%_dual_gbe.bin: %_gbe.bin
	cat $< $< > $@

%.bin: %_ifd.bin ich9_dual_gbe.bin
	dd if=/dev/zero of=$@.tmp count=24
	dd if=$< of=$@.tmp conv=notrunc
	ifdtool --inject GBE:ich9_dual_gbe.bin $@.tmp
	mv -f $@.tmp.new $@

ich9fdnogbe_%.bin: ich9fdnogbe_%.set ich9_ifd.spec
	bincfg ich9_ifd.spec $< $@

SHA512_LOG_COMPILER = sha512sum --strict -c
TEST_EXTENSIONS = .sha512
TESTS = \
	ich9fdgbe_16m.bin.sha512 \
	ich9fdgbe_16m_ro.bin.sha512 \
	ich9fdgbe_4m.bin.sha512 \
	ich9fdgbe_4m_ro.bin.sha512 \
	ich9fdgbe_8m.bin.sha512 \
	ich9fdgbe_8m_ro.bin.sha512 \
	ich9fdnogbe_16m.bin.sha512 \
	ich9fdnogbe_16m_ro.bin.sha512 \
	ich9fdnogbe_4m.bin.sha512 \
	ich9fdnogbe_4m_ro.bin.sha512 \
	ich9fdnogbe_8m.bin.sha512 \
	ich9fdnogbe_8m_ro.bin.sha512 \
	$(SENTINEL)
