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
GUIX_COMMIT ?= 07f19ef04b5a8f4d7a12a8940333e67db8da81c0

DOMAIN := gnu.org/software/gnuboot

.PHONY: all check help deploy

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

# We want to update the tarball when guix commit changes. The trick to
# make that work is to only create or update a file when the revision
# changes.
if WANT_GUIX
guix-commit.txt: Makefile
	if [ ! -f $@ ] || [ "$(cat $@)" != "$(GUIX_COMMIT)" ] ; then \
		echo -n "$(GUIX_COMMIT)" > $@ ; \
	fi
else
guix-commit.txt: Makefile
	if [ ! -f $@ ] || [ "$(cat $@)" != "" ] ; then \
		echo -n "" > $@ ; \
	fi
endif

# When we use an external lbwww repository, we don't want to rebuild
# the tarball each time in case something changes. Since Make uses
# timestamps, we store the hash of the timestamps and compare that to
# the hash of the last build to see if we need to rebuild the tarball.
if WANT_LBWWW_PATH
LBWWW_PATH_HASH := `ls -alR --full-time $(LBWWW_PATH) | sha1sum`
lbwww-path-sha1sum.txt: Makefile
	if [ ! -f $@ ] || [ "$(cat $@)" != "$(LBWWW_PATH_HASH)" ] ; then \
		echo -n "$(LBWWW_PATH_HASH)" > $@ ; \
	fi
else
lbwww-path-sha1sum.txt: Makefile
	if [ ! -f $@ ] || [ "$(cat $@)" != "" ] ; then \
		echo -n "" > $@ ; \
	fi
endif

# When we use an external lbwww-img repository, we don't want to
# rebuild the tarball each time in case something changes. Since Make
# uses timestamps, we store the hash of the timestamps and compare
# that to the hash of the last build to see if we need to rebuild the
# tarball.
if WANT_LBWWW_IMG_PATH
LBWWW_IMG_PATH_HASH := `ls -alR --full-time $(LBWWW_IMG_PATH) | sha1sum`
lbwww-img-path-sha1sum.txt: Makefile
	if [ ! -f $@ ] || [ "$(cat $@)" != "$(LBWWW_IMG_PATH_HASH)" ] ; then \
		echo -n "$(LBWWW_PATH_HASH)" > $@ ; \
	fi
else
lbwww-img-path-sha1sum.txt: Makefile
	if [ ! -f $@ ] || [ "$(cat $@)" != "" ] ; then \
		echo -n "" > $@ ; \
	fi
endif

# When we use an external untitled repository, we don't want to
# rebuild the tarball each time in case something changes. Since Make
# uses timestamps, we store the hash of the timestamps and compare
# that to the hash of the last build to see if we need to rebuild the
# tarball.
if WANT_UNTITLED_PATH
UNTITLED_PATH_HASH := `ls -alR --full-time $(UNTITLED_PATH) | sha1sum`
untitled-path-sha1sum.txt: Makefile
	if [ ! -f $@ ] || [ "$(cat $@)" != "$(UNTITLED_PATH_HASH)" ] ; then \
		echo -n "$(UNTITLED_PATH_HASH)" > $@ ; \
	fi
else
untitled-path-sha1sum.txt: Makefile
	if [ ! -f $@ ] || [ "$(cat $@)" != "" ] ; then \
		echo -n "" > $@ ; \
	fi
endif

WEBSITE_BUILD_DEPENDENCIES = \
	build.sh \
	guix-commit.txt \
	lbwww-path-sha1sum.txt \
	lbwww-img-path-sha1sum.txt \
	Makefile \
	untitled-path-sha1sum.txt

if WANT_GUIX
website-commits.txt: $(WEBSITE_BUILD_DEPENDENCIES)
	guix time-machine \
	--commit=$(GUIX_COMMIT) \
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
	cat $(WEBSITE_BUILD_DEPENDENCIES) > $@
else
website-commits.txt: $(WEBSITE_BUILD_DEPENDENCIES)
	./build.sh $(BUILD_OPTIONS)
	cat $(WEBSITE_BUILD_DEPENDENCIES) > $@
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

RSYNC_OPTIONS := -av --progress
deploy: website.tar.gz
	rm -rf deploy
	mkdir -p deploy
	tar xf website.tar.gz -C deploy
	rsync $(RSYNC_OPTIONS) \
		deploy/ \
		$(RSYNC_DESTINATION)/

# See https://reproducible-builds.org/docs/archives/ for more details
website.tar.gz: website-commits.txt
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
