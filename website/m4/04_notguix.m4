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
## CHECK_GNUBOOT_WEBSITE_COMMON_DEPENDENCIES  -- Check for common dependencies between Guix and non Guix builds
## CHECK_GNUBOOT_WEBSITE_NOTGUIX_DEPENDENCIES -- Check dependencies for non Guix builds

# CHECK_GNUBOOT_WEBSITE_COMMON_DEPENDENCIES -- Check for common dependencies between Guix and non Guix builds
#
# Usage: CHECK_GNUBOOT_WEBSITE_COMMON_DEPENDENCIES
#
AC_DEFUN([CHECK_GNUBOOT_WEBSITE_COMMON_DEPENDENCIES],
 [AC_CHECK_PROG([FOUND_AWK], [awk], [awk])
  AS_IF([test x"$FOUND_AWK" = x""],
        [AC_MSG_ERROR([awk was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_CAT], [cat], [cat])
  AS_IF([test x"$FOUND_CAT" = x""],
        [AC_MSG_ERROR([cat was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_CVS], [cvs], [cvs])
  AS_IF([test x"$FOUND_CVS" = x""],
        [AC_MSG_ERROR([cvs was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_MKDIR], [mkdir], [mkdir])
  AS_IF([test x"$FOUND_MKDIR" = x""],
        [AC_MSG_ERROR([mkdir was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_PRINTF], [printf], [printf])
  AS_IF([test x"$FOUND_PRINTF" = x""],
        [AC_MSG_ERROR([printf was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_REALPATH], [realpath], [realpath])
  AS_IF([test x"$FOUND_REALPATH" = x""],
        [AC_MSG_ERROR([realpath was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_RM], [rm], [rm])
  AS_IF([test x"$FOUND_RM" = x""],
        [AC_MSG_ERROR([rm was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_SED], [sed], [sed])
  AS_IF([test x"$FOUND_SED" = x""],
        [AC_MSG_ERROR([sed was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_TAR], [tar], [tar])
  AS_IF([test x"$FOUND_TAR" = x""],
        [AC_MSG_ERROR([tar was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_WGET], [wget], [wget])
  AS_IF([test x"$FOUND_WGET" = x""],
        [AC_MSG_ERROR([wget was not found in PATH ($PATH)])])
 ])

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

# CHECK_GNUBOOT_WEBSITE_NOTGUIX_DEPENDENCIES -- Check dependencies for non Guix builds
#
# Usage: CHECK_GNUBOOT_WEBSITE_NOTGUIX_DEPENDENCIES(want_lighttpd)
#
AC_DEFUN([CHECK_GNUBOOT_WEBSITE_NOTGUIX_DEPENDENCIES],
 [AC_CHECK_PROG([FOUND_CP], [cp], [cp])
  AS_IF([test x"$FOUND_CP" = x""],
        [AC_MSG_ERROR(
         [cp was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_DATE], [date], [date])
  AS_IF([test x"$FOUND_DATE" = x""],
        [AC_MSG_ERROR(
         [date was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_DOT], [dot], [dot])
  AS_IF([test x"$FOUND_DOT" = x""],
        [AC_MSG_ERROR(
         [dot was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_FIND], [find], [find])
  AS_IF([test x"$FOUND_FIND" = x""],
        [AC_MSG_ERROR(
         [find was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_GM], [gm], [gm])
  AS_IF([test x"$FOUND_GM" = x""],
        [AC_MSG_ERROR(
         [gm was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_GREP], [grep], [grep])
  AS_IF([test x"$FOUND_GREP" = x""],
        [AC_MSG_ERROR(
         [grep was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_HEAD], [head], [head])
  AS_IF([test x"$FOUND_HEAD" = x""],
        [AC_MSG_ERROR(
         [head was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_GIT], [git], [git])
  AS_IF([test x"$FOUND_GIT" = x""],
        [AC_MSG_ERROR(
         [git was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_GZIP], [gzip], [gzip])
  AS_IF([test x"$FOUND_GZIP" = x""],
        [AC_MSG_ERROR(
         [gzip was not found in PATH ($PATH)])])

  AS_IF($1,
        [AC_CHECK_PROG([FOUND_LIGHTTPD], [lighttpd], [lighttpd])
         AS_IF([test x"$FOUND_LIGHTTPD" = x""],
               [AC_MSG_ERROR(
               [lighttpd was not found in PATH ($PATH)])])

         dnl The perl program (web-symlinks) that generate
         dnl symlinks from .symlinks files requires perl and the URI PERL
         dnl module.
         AC_PROG_PERL([5.0.0])
         AC_PROG_PERL_MOD([URI])
	],
        [AC_CHECK_PROG([FOUND_FALSE], [false], [false])
         AS_IF([test x"$FOUND_FALSE" = x""],
               [AC_MSG_ERROR(
               [false was not found in PATH ($PATH)])])])

  AC_CHECK_PROG([FOUND_PANDOC], [pandoc], [pandoc])
  AS_IF([test x"$FOUND_PANDOC" = x""],
        [AC_MSG_ERROR(
         [pandoc was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_TAIL], [tail], [tail])
  AS_IF([test x"$FOUND_TAIL" = x""],
        [AC_MSG_ERROR(
         [tail was not found in PATH ($PATH)])])

  AC_CHECK_PROG([FOUND_TEST], [test], [test])
  AS_IF([test x"$FOUND_TEST" = x""],
        [AC_MSG_ERROR(
         [test was not found in PATH ($PATH)])])

  CHECK_GNUBOOT_MANUAL_DEPENDENCIES
 ])
