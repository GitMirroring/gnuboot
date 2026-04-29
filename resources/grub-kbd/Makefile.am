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

pkgdata_DATA = \
	colemak.gkb \
	deqwertz.gkb \
	esqwerty.gkb \
	frazerty.gkb \
	frdvbepo.gkb \
	itqwerty.gkb \
	svenska.gkb \
	trqwerty.gkb \
	ukdvorak.gkb \
	ukqwerty.gkb \
	usdvorak.gkb \
	usqwerty.gkb \
	$(SENTINEL)

if WANT_COLEMAK_DEFAULT_KEYMAP_DIR
COLEMAK_CKBCOMP_INCLUDES = -I$(COLEMAK_DEFAULT_KEYMAP_DIR)
else # WANT_COLEMAK_DEFAULT_KEYMAP_DIR
COLEMAK_CKBCOMP_INCLUDES = $(SENTINEL)
endif # WANT_COLEMAK_DEFAULT_KEYMAP_DIR

if WANT_TRQWERTY_DEFAULT_KEYMAP_DIR
TRQWERTY_CKBCOMP_INCLUDES = -I$(TRQWERTY_DEFAULT_KEYMAP_DIR)
else # WANT_TRQWERTY_DEFAULT_KEYMAP_DIR
TRQWERTY_CKBCOMP_INCLUDES = $(SENTINEL)
endif # WANT_TRQWERTY_DEFAULT_KEYMAP_DIR

colemak.map:
	./ckbcomp $(COLEMAK_CKBCOMP_INCLUDES) us colemak > $@
frdvbepo.map:
	./ckbcomp $(TRQWERTY_CKBCOMP_INCLUDES) fr bepo > $@
trqwerty.map:
	ckbcomp $(TRQWERTY_CKBCOMP_INCLUDES) tr > $@

SUFFIXES: .map.gkb .gkb
.map.gkb:
	grub-mklayout -i $< -o $@

SHA512_LOG_COMPILER = sha512sum --strict -c
TEST_EXTENSIONS = .sha512
TESTS = \
	colemak.gkb.sha512 \
	deqwertz.gkb.sha512 \
	esqwerty.gkb.sha512 \
	frazerty.gkb.sha512 \
	frdvbepo.gkb.sha512 \
	itqwerty.gkb.sha512 \
	svenska.gkb.sha512 \
	trqwerty.gkb.sha512 \
	ukdvorak.gkb.sha512 \
	ukqwerty.gkb.sha512 \
	usdvorak.gkb.sha512 \
	usqwerty.gkb.sha512 \
	$(SENTINEL)
