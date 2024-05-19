# Copyright (C) 2022-2023 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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

BUILD_OPTIONS :=
GUIX_SHARE_OPTIONS := --share=`realpath ../`

if WANT_UNTITLED_PATH
BUILD_OPTIONS += --with-untitled-path $(UNTITLED_PATH)
GUIX_SHARE_OPTIONS += --share=`realpath $(UNTITLED_PATH)`
endif

if WANT_GUIX
build:
	guix time-machine \
	--commit=c15a1cd88f80a90437f4b0159f22dfc84b9e6851 \
	-- shell \
		--container \
		--network \
		--emulate-fhs \
		$(GUIX_SHARE_OPTIONS) \
		bash \
		coreutils \
		findutils \
		git \
		grep \
		nss-certs \
		pandoc \
		sed \
		-- \
		./build.sh $(BUILD_OPTIONS)
else
build:
		./build.sh $(BUILD_OPTIONS)
endif

if WANT_GUIX
check: build website.tar.gz
	rm -rf site/
	mkdir -p site/software/gnuboot/
	tar xf website.tar.gz -C site/software/gnuboot/

	guix shell \
		--container \
		--network \
		--emulate-fhs \
		bash \
		coreutils \
		findutils \
		grep \
		gzip \
		sed \
		tar \
		-- \
		./check.sh --directory site && \
		./check.sh --tarball website.tar.gz
else
check: build website.tar.gz
	rm -rf site/
	mkdir -p site/software/gnuboot/
	tar xf website.tar.gz -C site/software/gnuboot/
	./check.sh --directory site
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
serve: website.tar.gz
	guix shell \
		--container \
		--network \
		--emulate-fhs \
		bash \
		coreutils \
		gzip \
		lighttpd \
		sed \
		tar \
		-- \
		./serve.sh website.tar.gz $(LIGHTTPD_PORT)
else
if WANT_LIGHTTPD
serve: website.tar.gz
		./serve.sh website.tar.gz $(LIGHTTPD_PORT)
else
serve:
	@printf "%s %s\n" \
		"The test target is disabled." \
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
		untitled/www/lbwww/site \
		index.html \
		--transform="s#untitled/www/lbwww/site#web#"
