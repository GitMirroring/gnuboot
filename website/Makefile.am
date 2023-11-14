# Copyright (C) 2022-2024 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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
.PHONY: all build check help publish serve website.tar.gz

all: help

if WANT_GUIX
build:
	guix time-machine \
	--commit=v1.4.0 \
	-- shell \
		haunt
		-- \
		haunt build
else
build:
		haunt build
endif

if WANT_GUIX
check: website.tar.gz
	guix shell \
		--container \
		--network \
		--emulate-fhs \
		bash \
		coreutils \
		grep \
		gzip \
		tar \
		-- \
		./check.sh --tarball website.tar.gz
else
check: website.tar.gz
		./check.sh --tarball website.tar.gz
endif

help:
	@printf "%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n" \
		"Available commands:" \
		"help           # Print this help" \
		"build          # Build the website" \
		"serve          # run lighttpd on localhost:$(LIGHTTPD_PORT)" \
		"publish        # Publish the website to https://gnu.org/software/gnuboot" \
		"check          # Run automatic tests" \
		"website.tar.gz # Create a tarball of the website"

if WANT_GUIX
serve: build
	guix shell \
		--container \
		--network \
		--emulate-fhs \
		bash \
		coreutils \
		lighttpd \
		sed \
		-- \
		./serve.sh $(LIGHTTPD_PORT)
else
if WANT_LIGHTTPD
serve: build
		./serve.sh $(LIGHTTPD_PORT)
else
serve:
	@printf "%s %s\n" \
		"The serve target is disabled." \
		"To enable it, run './configure --enable-lighttpd'."
	@false
endif
endif

# The rsync options are hardcoded here because some options are known
# not to work. For instance --delete results in rsync hanging. Also
# note that it's possible to rsync some files to gnu.org but not from
# gnu.org.
RSYNC_OPTIONS := -av --progress
publish: website.tar.gz
	rm -rf deploy
	mkdir -p deploy
	tar xf website.tar.gz -C deploy
	rsync $(RSYNC_OPTIONS) \
		deploy/ \
		$(RSYNC_DESTINATION)/

website.tar.gz: build
	tar \
		--exclude-vcs \
		--format=gnu \
		--owner=0 --group=0 --numeric-owner \
		--sort=name \
		-czf \
		website.tar.gz \
		site
