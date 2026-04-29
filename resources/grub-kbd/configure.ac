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

AC_PREREQ([2.68])
AC_INIT([gnuboot-grub-kbd],[0.1],[gnuboot-patches@gnu.org])
AC_CONFIG_SRCDIR([COPYING])
AM_INIT_AUTOMAKE([foreign])

AC_SUBST([COLEMAK_DEFAULT_KEYMAP_DIR], [])
AC_SUBST([TRQWERTY_DEFAULT_KEYMAP_DIR], [])

AC_CHECK_PROG([FOUND_GRUB_KBDCOMP], [grub-kbdcomp], [grub-kbdcomp])
AS_IF([test x"$FOUND_GRUB_KBDCOMP" = x""],
      [AC_MSG_ERROR(
      [grub-kbdcomp was not found in PATH ($PATH)])])

# --with-colemak-default-keymap-dir
AC_ARG_WITH([colemak-default-keymap-dir],
  [AS_HELP_STRING([--with-colemak-default-keymap-dir=DIR],
                  [Search for colemak keymap description in DIR first. If the
		   required file is not found it will then be searched in
		   standard locations like /usr/share/X11/xkb, /etc/X11/xkb,
		   /etc/console-setup/ckb, etc.])],
  [COLEMAK_DEFAULT_KEYMAP_DIR=$withval],
  [])
AM_CONDITIONAL( [WANT_COLEMAK_DEFAULT_KEYMAP_DIR],
                [test x"$COLEMAK_DEFAULT_KEYMAP_DIR" != x""])

# --with-trqwerty-default-keymap-dir
AC_ARG_WITH([trqwerty-default-keymap-dir],
  [AS_HELP_STRING([--with-trqwerty-default-keymap-dir=DIR],
                  [Search for trqwerty keymap description in DIR first. If the
		   required file is not found it will then be searched in
		   standard locations like /usr/share/X11/xkb, /etc/X11/xkb,
		   /etc/console-setup/ckb, etc.])],
  [TRQWERTY_DEFAULT_KEYMAP_DIR=$withval],
  [])
AM_CONDITIONAL( [WANT_TRQWERTY_DEFAULT_KEYMAP_DIR],
                [test x"$TRQWERTY_DEFAULT_KEYMAP_DIR" != x""])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
