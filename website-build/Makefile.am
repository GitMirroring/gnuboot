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
DOMAIN := libreboot.at

.PHONY: all build check help deploy website.tar.gz

all: website.tar.gz

BUILD_OPTIONS :=
GUIX_SHARE_OPTIONS :=

if WANT_LBWWW_PATH
BUILD_OPTIONS += --with-lbwww-path $(LBWWW_PATH)
GUIX_SHARE_OPTIONS += --share=`realpath $(LBWWW_PATH)`
endif

if WANT_UNTITLED_PATH
BUILD_OPTIONS += --with-untitled-path $(UNTITLED_PATH)
GUIX_SHARE_OPTIONS += --share=`realpath $(UNTITLED_PATH)`
endif

if WANT_GUIX
build:
	guix time-machine \
	--commit=07f19ef04b5a8f4d7a12a8940333e67db8da81c0 \
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
		./build.sh $(BUILD_OPTIONS)
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
	@printf "%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n" \
		"Available commands:" \
		"help           # Print this help" \
		"test           # run lighttpd on localhost:8080" \
		"check          # Run automatic tests" \
		"deploy         # Deploy the website to https://$(DOMAIN)" \
		"website.tar.gz # Create a tarball of the website"

if WANT_GUIX
test: website.tar.gz
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
		./serve.sh website.tar.gz
else
if WANT_LIGHTTPD
test: website.tar.gz
		./serve.sh website.tar.gz
else
test:
	@printf "%s %s\n" \
		"The test target is disabled." \
		"To enable it, run './configure --enable-lighttpd'."
	@false
endif
endif

deploy: website.tar.gz
	curl \
		--oauth2-bearer `cat id_oauth2_bearer` \
		-Fcontent=@website.tar.gz \
		https://pages.sr.ht/publish/$(DOMAIN)

# See https://reproducible-builds.org/docs/archives/ for more details
website.tar.gz: build
	tar \
		--exclude-vcs \
		--format=gnu \
		--mtime='1970-01-01 00:00Z' \
		--owner=0 --group=0 --numeric-owner \
		--sort=name \
		-czf \
		website.tar.gz \
		untitled/www/lbwww/site \
		index.html \
		test/index.html \
		--transform="s#untitled/www/lbwww/site#test/web#"
