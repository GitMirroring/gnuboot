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

BUILD_OPTIONS :=
GUIX_SHARE_OPTIONS := --share=`realpath ../`

if WANT_UNTITLED_PATH
BUILD_OPTIONS += --with-untitled-path $(UNTITLED_PATH)
GUIX_SHARE_OPTIONS += --share=`realpath $(UNTITLED_PATH)`
endif

index.html: index.html.tmpl
	sed -e "s#WEBSITE_PREFIX#$(WEBSITE_PREFIX)#g" "$^" > "$@"

if WANT_GUIX
history/git-history.jpg: history/git-history.dot
	guix time-machine \
	--commit=$(GUIX_REVISION) \
	-- \
	shell \
		--system=i686-linux \
		--container \
		graphviz \
	-- \
	dot -T jpg history/git-history.dot > "$@"
else
history/git-history.jpg: history/git-history.dot
	dot -T jpg history/git-history.dot > "$@"
endif

# We need force the regeneration of the page because if only the git
# commit changes, there is no way to know about it. In addition the
# full website is regenerated each time the build target is run, so
# generating one more page has insignificant performance impact.
.PHONY: pages/footer-git-commit.include
pages/footer-git-commit.include:
	rm -f $@

	printf "This page was generated with %s from the commit %s\n" \
		"[Untitled](https://untitled.vimuser.org/)" \
		"`git show --no-patch HEAD --pretty=\"%h\"`" \
		>> $@

	printf "(\"%s\").\n" \
		"`git show --no-patch HEAD --pretty=\"%s\"`" \
		>> $@

	printf "\n" >> $@

pages/footer.include: pages/footer.include.tmpl pages/footer-git-commit.include
	cat \
		pages/footer.include.tmpl \
		pages/footer-git-commit.include \
		> $@

site.cfg: site.cfg.tmpl
	sed -e "s#WEBSITE_PREFIX#$(WEBSITE_PREFIX)#g" "$^" > "$@"

if WANT_GUIX
build: site.cfg pages/footer.include
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
build: site.cfg pages/footer.include
		./build.sh $(BUILD_OPTIONS)
endif

if WANT_GUIX
check: build website.tar.gz index.html history/git-history.jpg
	rm -rf site/
	mkdir -p site/$(WEBSITE_PREFIX)
	tar xf website.tar.gz -C site/$(WEBSITE_PREFIX)

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
		./check.sh --website-prefix $(WEBSITE_PREFIX) \
			--directory site && \
		./check.sh  --website-prefix $(WEBSITE_PREFIX) \
			--tarball website.tar.gz
else
check: build website.tar.gz index.html history/git-history.jpg
	rm -rf site/
	mkdir -p site/$(WEBSITE_PREFIX)
	tar xf website.tar.gz -C site/$(WEBSITE_PREFIX)
	./check.sh --website-prefix $(WEBSITE_PREFIX) --directory site
	./check.sh --website-prefix $(WEBSITE_PREFIX) --tarball website.tar.gz
endif

help:
	@printf "%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n" \
		"Available commands:" \
		"help           # Print this help" \
		"build          # Build the website" \
		"serve          # run lighttpd on localhost:$(LIGHTTPD_PORT)" \
		"publish        # Publish the website to https://gnu.org/$(WEBSITE_PREFIX)" \
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
		./serve.sh --website-prefix $(WEBSITE_PREFIX) \
			website.tar.gz $(LIGHTTPD_PORT)
else
if WANT_LIGHTTPD
serve: website.tar.gz
		./serve.sh --website-prefix $(WEBSITE_PREFIX) \
			website.tar.gz $(LIGHTTPD_PORT)
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

website.tar.gz: build index.html history/git-history.jpg
	tar \
		--exclude-vcs \
		--format=gnu \
		--owner=0 --group=0 --numeric-owner \
		--sort=name \
		-czf \
		website.tar.gz \
		untitled/www/lbwww/site \
		index.html \
		history/git-history.dot \
		history/git-history.jpg \
		--transform="s#untitled/www/lbwww/site#web#" \
		--transform="s#^history/#web/history/#"
