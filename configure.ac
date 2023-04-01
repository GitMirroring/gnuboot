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

AC_INIT([lbwww-build],[0.1],[GNUtoo@cyberdimension.org])
AM_INIT_AUTOMAKE([foreign])
AC_CONFIG_FILES([Makefile])

AC_SUBST([LBWWW_PATH], [])
AC_SUBST([LBWWW_GIT_FOUND], [])
AC_SUBST([LBWWW_IMG_PATH], [])
AC_SUBST([LBWWW_IMG_GIT_FOUND], [])

# Check dependencies
AC_CHECK_PROG([CAT], [cat], [cat])
AC_CHECK_PROG([CP], [cp], [cp])
AC_CHECK_PROG([CURL], [curl], [curl])
AC_CHECK_PROG([GUIX], [guix], [guix])
AC_CHECK_PROG([PRINTF], [printf], [printf])
AC_CHECK_PROG([REALPATH], [realpath], [realpath])
AC_CHECK_PROG([TAR], [tar], [tar])

# --with-lbwww-path
AC_ARG_WITH([lbwww-path],
  [AS_HELP_STRING([--with-lbwww-path=PATH],
                  [Use a local lbwww directory from PATH instead of downloading
		   the latest version from https://git.sr.ht/~libreboot/lbwww])],
  [LBWWW_PATH=$withval],
  [])

AM_CONDITIONAL( [WANT_LBWWW_PATH], [test x"$LBWWW_PATH" != x""])

# --with-lbwww-img-path
AC_ARG_WITH([lbwww-img-path],
  [AS_HELP_STRING([--with-lbwww-img-path=PATH],
                  [Use a local lbwww-img directory from PATH instead of downloading
		   the latest version from https://git.sr.ht/~libreboot/lbwww-img])],
  [LBWWW_IMG_PATH=$withval],
  [])

AM_CONDITIONAL( [WANT_LBWWW_IMG_PATH], [test x"$LBWWW_IMG_PATH" != x""])

AC_OUTPUT

AS_IF([test x"$LBWWW_PATH" != x"" || test x"$LBWWW_IMG_PATH" != x""],
      [AS_ECHO(["Configuration options:"])
       AS_ECHO([])])

AS_IF([test x"$LBWWW_PATH" != x""],
      [AS_ECHO(["    LBWWW_PATH: $LBWWW_PATH"])])

AS_IF([test x"$LBWWW_IMG_PATH" != x""],
      [AS_ECHO(["    LBWWW_IMG_PATH: $LBWWW_IMG_PATH"])])
