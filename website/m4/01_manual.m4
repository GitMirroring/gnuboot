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

## Index
## -----
##
## CHECK_GNUBOOT_MANUAL_DEPENDENCIES -- Check dependencies for the GNU Boot manual

# CHECK_GNUBOOT_MANUAL_DEPENDENCIES -- Check dependencies for the GNU Boot manual
#
# Usage: CHECK_GNUBOOT_MANUAL_DEPENDENCIES
#
AC_DEFUN([CHECK_GNUBOOT_MANUAL_DEPENDENCIES],
 [AC_CHECK_PROG([FOUND_MAKEINFO], [makeinfo], [makeinfo])
  AS_IF([test x"$FOUND_MAKEINFO" = x""],
        [AC_MSG_ERROR(
         [makeinfo was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_TEX], [tex], [tex])
  AS_IF([test x"$FOUND_TEX" = x""],
        [AC_MSG_ERROR(
         [tex was not found in PATH ($PATH)])])
 ])
