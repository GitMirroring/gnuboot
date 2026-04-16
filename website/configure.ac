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

dnl See "10 Writing Autoconf Macros" in autoconf info manual

AC_CONFIG_MACRO_DIRS([m4])

AC_INIT([gnuboot],[0.1],[gnuboot@gnu.org])
AM_INIT_AUTOMAKE([foreign])
AC_CONFIG_FILES([Makefile])

AC_SUBST([LBSSG_GIT_FOUND], [])
AC_SUBST([LBSSG_PATH], [])
AC_SUBST([LIGHTTPD_PORT], [])
AC_SUBST([RSYNC_DESTINATION], [])
AC_SUBST([WEB_SYMLINKS_PATH], [])
AC_SUBST([WEBSITE_PREFIX], [])

# --enable-guix
AC_ARG_ENABLE(guix,
  [AS_HELP_STRING([--enable-guix], [Use guix to run the scripts (default=enabled)])],
  [guix=$enableval],
  [guix="yes"])
AM_CONDITIONAL( [WANT_GUIX], [test x"$guix" = x"yes"])

# Use the same revision than ../configure.ac
AC_SUBST([GUIX_REVISION],
	 [`\`dirname $0\`/../guix-revision.sh print-variable GUIX_REVISION`])

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

AM_CONDITIONAL( [WANT_RSYNC_DESTINATION], [test x"$RSYNC_DESTINATION" != x""])

# --with-web-symlinks-path
AC_ARG_WITH([web-symlinks-path],
  [AS_HELP_STRING([--with-web-symlinks-path=PATH],
                  [Use the web-symlinks perl program from the given directory
		   instead of downloading it from
		   cvs.savannah.gnu.org:/sources/www with CVS.])],
  [WEB_SYMLINKS_PATH=`realpath $withval`],
  [])

AM_CONDITIONAL([WANT_WEB_SYMLINKS_PATH], [test x"$WEB_SYMLINKS_PATH" != x""])

# --with-lbssg-path
AC_ARG_WITH([lbssg-path],
  [AS_HELP_STRING([--with-lbssg-path=PATH],
                  [Use a local lbssg directory from PATH instead of downloading
		   a specific version from
		   https://codeberg.org/libreboot/lbssg .])],
  [LBSSG_PATH=$withval],
  [])

AM_CONDITIONAL( [WANT_LBSSG_PATH], [test x"$LBSSG_PATH" != x""])

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

AM_CONDITIONAL( [WANT_WEBSITE_PREFIX], [test x"WEBSITE_PREFIX" != x""])

CHECK_GNUBOOT_WEBSITE_COMMON_DEPENDENCIES
AS_IF([test x"$guix" = x"yes"],
      [AC_PROG_GUIX],
      [CHECK_GNUBOOT_WEBSITE_NONGUIX_DEPENDENCIES([test x"$lighttpd" = x"yes"])])

# We want to only set the Guix revision being used only in one place
# to avoid forgetting to also update it on other places it would have
# been set.
`dirname $0`/../guix-revision.sh print-texinfo > ../manual/guix-revision.texi

AC_OUTPUT
AS_ECHO(["Configuration options:"])

AS_ECHO(["    LIGHTTPD_PORT: $LIGHTTPD_PORT"])

AS_ECHO(["    RSYNC_DESTINATION: $RSYNC_DESTINATION"])

AS_IF([test x"$LBSSG_PATH" != x""],
      [AS_ECHO(["    LBSSG_PATH: $LBSSG_PATH"])])

AS_IF([test x"$WEB_SYMLINKS_PATH" != x""],
      [AS_ECHO(["    WEB_SYMLINKS_PATH: $WEB_SYMLINKS_PATH"])])

AS_ECHO(["    WEBSITE_PREFIX: $WEBSITE_PREFIX"])
