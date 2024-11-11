# Copyright (C) 2023 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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

AC_INIT([gnuboot],[0.1],[gnuboot@gnu.org])
AM_INIT_AUTOMAKE([foreign])
AC_CONFIG_FILES([Makefile])

AC_SUBST([LIGHTTPD_PORT], [])
AC_SUBST([RSYNC_DESTINATION], [])
AC_SUBST([UNTITLED_PATH], [])
AC_SUBST([UNTITLED_GIT_FOUND], [])
AC_SUBST([WEBSITE_PREFIX], [])

# --enable-guix
AC_ARG_ENABLE(guix,
  [AS_HELP_STRING([--enable-guix], [Use guix to run the scripts (default=enabled)])],
  [guix=$enableval],
  [guix="yes"])
AM_CONDITIONAL( [WANT_GUIX], [test x"$guix" = x"yes"])

# --enable-lighttpd
AC_ARG_ENABLE(lighttpd,
  [AS_HELP_STRING([--enable-lighttpd],
                  [Use lighttpd to run the scripts (default=enabled)])],
  [lighttpd=$enableval],
  [lighttpd="yes"])
AM_CONDITIONAL( [WANT_LIGHTTPD], [test x"$lighttpd" = x"yes"])

# --with-lighttpd-port
AC_ARG_WITH([lighttpd-port],
  [AS_HELP_STRING([--with-lighttpd-port=PORT],
                  [Use a custom TCP port for lighttpd tests instead of the
                   default one (8086).])],
  [LIGHTTPD_PORT=$withval],
  [LIGHTTPD_PORT=8086])

# --with-rsync-destination
AC_ARG_WITH([rsync-destination],
  [AS_HELP_STRING([--with-rsync-destination=DESTINATION],
                  [Use a custom rsync destination (DEST in rsync manual)
		   instead of the default one
		   (wwwcvs@gnu.org:/var/www/software/gnuboot).])],
  [RSYNC_DESTINATION=$withval],
  [RSYNC_DESTINATION=wwwcvs@gnu.org:/var/www/software/gnuboot])

AM_CONDITIONAL( [WANT_UNTITLED_PATH], [test x"$UNTITLED_PATH" != x""])

# --with-untitled-path
AC_ARG_WITH([untitled-path],
  [AS_HELP_STRING([--with-untitled-path=PATH],
                  [Use a local untitled directory from PATH instead of downloading
		   a specific version from
		   https://git.sr.ht/~libreboot/untitled .])],
  [UNTITLED_PATH=$withval],
  [])

AM_CONDITIONAL( [WANT_UNTITLED_PATH], [test x"$UNTITLED_PATH" != x""])

# --with-website-prefix
AC_ARG_WITH([website-prefix],
  [AS_HELP_STRING(
    [--with-website-prefix=PREFIX],
    [By default, the website is to be deployed to
     https://www.gnu.org/software/gnuboot/. But if you want to deploy to another
     URL like https://mysite.org/test/, you would need to change the website
     prefix to /test/ instead of the default one (software/gnuboot).])],
  [WEBSITE_PREFIX=$withval],
  [WEBSITE_PREFIX=software/gnuboot])

AM_CONDITIONAL( [WANT_UNTITLED_PATH], [test x"$UNTITLED_PATH" != x""])

# Check dependencies
AC_CHECK_PROG([FOUND_AWK], [awk], [awk])
AS_IF([test x"$FOUND_AWK" = x""],
      [AC_MSG_ERROR([awk was not found in PATH ($PATH)])])

AC_CHECK_PROG([FOUND_CAT], [cat], [cat])
AS_IF([test x"$FOUND_CAT" = x""],
      [AC_MSG_ERROR([cat was not found in PATH ($PATH)])])

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

AS_IF([test x"$guix" = x"yes"],
      [AC_CHECK_PROG([FOUND_GUIX], [guix], [guix])
       AS_IF([test x"$FOUND_GUIX" = x""],
             [AC_MSG_ERROR(
              [guix was not found in PATH ($PATH)])])],

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

       AS_IF([test x"$lighttpd" = x"yes"],
             [AC_CHECK_PROG([FOUND_LIGHTTPD], [lighttpd], [lighttpd])
              AS_IF([test x"$FOUND_LIGHTTPD" = x""],
                    [AC_MSG_ERROR(
                    [lighttpd was not found in PATH ($PATH)])])],
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
              [test was not found in PATH ($PATH)])])])

AC_OUTPUT
AS_ECHO(["Configuration options:"])

AS_ECHO(["    LIGHTTPD_PORT: $LIGHTTPD_PORT"])

AS_ECHO(["    RSYNC_DESTINATION: $RSYNC_DESTINATION"])

AS_IF([test x"$UNTITLED_PATH" != x""],
      [AS_ECHO(["    UNTITLED_PATH: $UNTITLED_PATH"])])

AS_ECHO(["    WEBSITE_PREFIX: $WEBSITE_PREFIX"])
