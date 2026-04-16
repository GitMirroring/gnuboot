# Copyright © 2002,2003,2004,2005,2006,2007,2008,2009,2010  Free Software Foundation, Inc.
# Copyright © 2026 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
#
# This file is part of GNU Boot.
#
# This file is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or (at
# your option) any later version.
#
# This file is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Boot.  If not, see <http://www.gnu.org/licenses/>.

dnl The Index and function documentation below follow the standards
dnl used by Guile.

## Index
## -----
##
## AC_PROG_PERL     -- Check for Perl
## AC_PROG_PERL_MOD -- Check for specific Perl module

# AC_PROG_PERL -- Check for Perl
#
# Usage: AC_PROG_PERL([VERSION])
#
# If VERSION is specified, it will check if the Perl interpreter in
# the PATH is compatible with the VERSION specified. If not it will
# only look if there is a Perl interpreter available in the PATH.

AC_DEFUN([AC_PROG_PERL],
         [AC_CHECK_PROG([FOUND_PERL], [perl], [perl])
          AS_IF([test x"$FOUND_PERL" = x""],
                [AC_MSG_ERROR([Perl was not found in PATH ($PATH)])])
          AS_IF([test x"$1" != x""],
                [dnl Modified from "checking for recent Pod::Man" from configure.ac
                 dnl from GCC which is under the GPLv2 or later.
                 AC_MSG_CHECKING([for Perl compatible with Perl $1])
		 AS_IF([(perl -e 'use $1;') >/dev/null 2>&1],
		       [AS_ECHO([$FOUND_PERL])],
		       [AC_MSG_ERROR([Perl requires at least version $1.])])
		])
         ])

# AC_PROG_PERL_MOD -- Check for Perl module
#
# Usage: AC_PROG_PERL_MOD([MODULE])
#
# Checks if the given MODULE is present by importing it by running
# 'use MODULE;' with the perl interpreter available in the PATH. It
# assumes that there is a perl interpreter in the PATH, so you need to
# run AC_PROG_PERL before using AC_PROG_PERL_MOD.

AC_DEFUN([AC_PROG_PERL_MOD],
         [AS_IF([test x"$1" != x""],
                [dnl Modified from "checking for recent Pod::Man" from configure.ac
                 dnl from GCC which is under the GPLv2 or later.
                 AC_MSG_CHECKING([for Perl module $1])
		 AS_IF([(perl -e 'use $1;') >/dev/null 2>&1],
		       [AS_ECHO([$1])],
		       [AC_MSG_ERROR([Requires Perl module $1.])])
		])
         ])
