/*
 * Copyright © 2026 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
 *
 * This file is part of GNU Boot.
 *
 * GNU Boot is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or (at
 * your option) any later version.
 *
 * GNU Boot is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GNU Boot.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <curses.h>
#include <libpayload.h>

int main(void)
{
	/* Clear the screen with ncurses to not have garbage after the
	 * GNU Boot revision
	 */
	initscr();
	clear();
	clrtobot();
	clrtoeol();
	refresh();

	printf("GNU Boot revision: %s.\n", "0.1 RC6");

	/* TODO: enable to quit and reboot (SeaBIOS) and/or go back in
	 * GRUB.
	 */

	/* hangs so we can see the prints */
	halt();

	return 0;
}
