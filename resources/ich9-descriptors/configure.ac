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
AC_INIT([gnuboot-ich9-descriptors],[0.1],[gnuboot@gnu.org])
AC_CONFIG_SRCDIR([ich9_gbe.set])
AM_INIT_AUTOMAKE([foreign])

AC_CHECK_PROG([FOUND_BINCFG], [bincfg], [bincfg])
AS_IF([test x"$FOUND_BINCFG" = x""],
      [AC_MSG_ERROR(
      [bincfg was not found in PATH ($PATH)])])

AC_CHECK_PROG([FOUND_CAT], [cat], [cat])
AS_IF([test x"$FOUND_CAT" = x""],
      [AC_MSG_ERROR(
      [cat was not found in PATH ($PATH)])])

AC_CHECK_PROG([FOUND_DD], [dd], [dd])
AS_IF([test x"$FOUND_DD" = x""],
      [AC_MSG_ERROR(
      [dd was not found in PATH ($PATH)])])

AC_CHECK_PROG([FOUND_IFDTOOL], [ifdtool], [ifdtool])
AS_IF([test x"$FOUND_IFDTOOL" = x""],
      [AC_MSG_ERROR(
      [ifdtool was not found in PATH ($PATH)])])

AC_CHECK_PROG([FOUND_MV], [mv], [mv])
AS_IF([test x"$FOUND_MV" = x""],
      [AC_MSG_ERROR(
      [mv was not found in PATH ($PATH)])])

AC_CHECK_PROG([FOUND_SHA512SUM], [sha512sum], [sha512sum])
AS_IF([test x"$FOUND_SHA512SUM" = x""],
      [AC_MSG_ERROR(
      [sha512sum was not found in PATH ($PATH)])])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
