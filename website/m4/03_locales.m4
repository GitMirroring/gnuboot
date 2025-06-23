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
## AC_CHECK_LOCALE     -- Check for specific locale

# AC_CHECK_LOCALE -- Check for specific locale
#
# Usage: AC_CHECK_LOCALE([VARIABLE, LOCALE, VALUE-IF-FOUND, [VALUE-IF-NOT-FOUND]])
#
# Checks if the given LOCALE is present with locale -a.

AC_DEFUN([AC_CHECK_LOCALE],
         [AS_IF([test x"$2" != x""],
                [AC_CHECK_PROG([FOUND_LOCALE], [locale], [locale])
                 AS_IF([test x"$FOUND_LOCALE" = x""],
                       [AC_MSG_ERROR([locale was not found in PATH ($PATH)])])
                 AC_MSG_CHECKING([for $2 locale])
                 for locale in `locale -a` ; do
                        AS_IF([test x"$1" = x"$locale"],
                              [$1=$3
                               break])
                 done
                 AS_IF([test x"$4" != x""],
                       [AS_IF([test x"$1" != x"$3"],[$1=$4])])
                ])])
