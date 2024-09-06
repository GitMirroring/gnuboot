# Copyright (C) 2024 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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
AC_CONFIG_FILES([
    Makefile
    resources/packages/i945-thinkpads-install-utilities/Makefile
])

AC_SUBST([GUIX_BUILD_MAX_CORES], [])

# --with-guix-build-max-cores
AC_ARG_WITH([guix-build-max-cores],
    [AS_HELP_STRING([--with-guix-build-max-cores=N],
                  [Force guix build the use of up to N CPU cores for the build.
                   Lowering the number of cores used can help when there is not
                   enough RAM per core.])],
    [GUIX_BUILD_MAX_CORES=$withval],
    [GUIX_BUILD_MAX_CORES=0])

AC_CHECK_PROG([FOUND_GUIX], [guix], [guix])
AS_IF([test x"$FOUND_GUIX" = x""],
      [AC_MSG_ERROR(
      [guix was not found in PATH ($PATH)])])

AC_CHECK_PROG([FOUND_GUIX], [guix], [guix])
AS_IF([test x"$FOUND_GUIX" = x""],
      [AC_MSG_ERROR(
      [guix was not found in PATH ($PATH)])])

AC_OUTPUT

AS_ECHO(["Configuration options:"])

AS_IF([test x"$GUIX_BUILD_MAX_CORES" = x"0"],
      AS_ECHO(["    GUIX_BUILD_MAX_CORES: not limited."]),
      AS_ECHO(["    GUIX_BUILD_MAX_CORES: $GUIX_BUILD_MAX_CORES"]))
