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
SENTINEL =

.PHONY: all build check help publish serve website.tar.gz

all: help

BUILD_OPTIONS :=
GUIX_SHARE_OPTIONS := --share=`realpath ../`

if WANT_UNTITLED_PATH
BUILD_OPTIONS += --with-untitled-path $(UNTITLED_PATH)
GUIX_SHARE_OPTIONS += --share=`realpath $(UNTITLED_PATH)`
endif

GUIX_SHELL_CONTAINER = guix time-machine \
	--commit=$(GUIX_REVISION) \
	-- \
	shell \
	--system=i686-linux \
	--container \
	`guix repl force-bordeaux-substitute.scm force` \
	$(SENTINEL)

if WANT_GUIX
DOT_CMD = $(GUIX_SHELL_CONTAINER) \
	graphviz \
	-- \
	dot
else
DOT_CMD = dot
endif

history/git-history.jpg: history/git-history.dot
	$(DOT_CMD) -T jpg history/git-history.dot > "$@"

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
# We can't use MAKEINFO as it's defined in configure.ac
MAKEINFO_CMD = $(GUIX_SHELL_CONTAINER) \
	--expose=`realpath ../manual/` \
	coreutils \
	diffutils \
	gcc-toolchain \
	grep \
	sed \
	tar \
	texinfo \
	texlive-bin \
	texlive-cm \
	texlive-epsf \
	texlive-kpathsea \
	texlive-latex-base \
	texlive-metafont \
	texlive-tex-texinfo \
	-- \
	makeinfo
else
MAKEINFO_CMD = makeinfo
endif

../manual/version.texi: Makefile
	@if git --no-pager name-rev --tags HEAD | awk '{print $$2}' | grep -q '^tags/' ; then \
		printf '@set VERSION %s' \
		`git describe --tag HEAD` > $@ ; \
	else \
		printf '@set VERSION %s' \
		`git --no-pager show --no-patch HEAD --pretty="%h"` > $@ ; \
	fi

# If we use GNUBOOT_MANUAL_DEPENDENCIES, autoreconf 2.71 will output the
# following warning:
#     Makefile.am:115: warning: variable 'GNUBOOT_MANUAL_DEPENDENCIES' is
#     defined but no program or
#     Makefile.am:115: library has 'GNUBOOT_MANUAL' as canonical name (possible
#     typo)
# Some other variable names are also reserved by automake such as
# *_SOURCES, so we used GNUBOOT_MANUAL_FILES to avoid conflicts or
# potentially unintended side effects.
GNUBOOT_MANUAL_FILES = \
	../manual/fdl-1.3.texi \
	../manual/gnuboot.texi \
	../manual/images/SOIC-16.png \
	../manual/version.texi \
	Makefile \
	$(SENTINEL)

pages/manual/gnuboot.%: $(GNUBOOT_MANUAL_FILES)
	mkdir -p `dirname $@`
	$(MAKEINFO_CMD) \
		 --$(subst pages/manual/gnuboot.,,$@) \
		--no-split \
		-o $@ \
		../manual/gnuboot.texi

if WANT_GUIX
GM_CMD = $(GUIX_SHELL_CONTAINER) \
	--expose=`realpath ../manual/` \
	graphicsmagick \
	-- \
	gm
else
GM_CMD = gm
endif

pages/manual/images/SOIC-16.png: ../manual/images/SOIC-16.jpeg
	mkdir -p `dirname $@`
	$(GM_CMD) convert $< $@

# In the manual we include SOIC-16.png as @image{images/SOIC-16,
# [...]}. This was done to make it easier to later on package the
# manual in FHS distributions like Trisquel as the info manual ends up
# in /usr/share/info/ while its images are expected to go in
# /usr/share/info/images instead. But then the manual also
# needs to be able to find its images during the compilation.
../manual/images/SOIC-16.png: pages/manual/images/SOIC-16.png
	mkdir -p `dirname $@`
	install -m 644 $< $@

pages/manual/images/SOIC-16.jpeg: ../manual/images/SOIC-16.jpeg
	mkdir -p `dirname $@`
	install -m 644 $< $@

GNUBOOT_MANUAL = \
	pages/manual/images/SOIC-16.jpeg \
	pages/manual/images/SOIC-16.png \
	pages/manual/gnuboot.html \
	pages/manual/gnuboot.pdf \
	$(SENTINEL)

if WANT_GUIX
BUILD_SH_CMD = $(GUIX_SHELL_CONTAINER) \
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
	./build.sh
else
BUILD_SH_CMD = ./build.sh
endif

build: site.cfg pages/footer.include $(GNUBOOT_MANUAL)
	$(BUILD_SH_CMD) $(BUILD_OPTIONS)

if WANT_GUIX
CHECK_SH_CMD = $(GUIX_SHELL_CONTAINER) \
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
	./check.sh
else
CHECK_SH_CMD = ./check.sh
endif

check: build website.tar.gz history/git-history.jpg
	rm -rf site/
	mkdir -p site/$(WEBSITE_PREFIX)
	tar xf website.tar.gz -C site/$(WEBSITE_PREFIX)
	$(CHECK_SH_CMD) --website-prefix $(WEBSITE_PREFIX) \
		--directory site
	$(CHECK_SH_CMD) --website-prefix $(WEBSITE_PREFIX) \
		--tarball website.tar.gz

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
SERVE_SH_CMD = $(GUIX_SHELL_CONTAINER) \
	--network \
	--emulate-fhs \
	bash \
	coreutils \
	gzip \
	lighttpd \
	sed \
	tar \
	-- \
	./serve.sh
else
SERVE_SH_CMD = ./serve.sh
endif

if ! WANT_LIGHTTPD
serve:
	@printf "%s %s\n" \
		"The $@ target is disabled." \
		"To enable it, run './configure --enable-lighttpd'."
	@false
else
serve: website.tar.gz
	$(SERVE_SH_CMD) --website-prefix $(WEBSITE_PREFIX) \
			website.tar.gz $(LIGHTTPD_PORT)
endif

RSYNC_OPTIONS := -av --progress --delete
publish: website.tar.gz
	rm -rf deploy
	mkdir -p deploy
	tar xf website.tar.gz -C deploy
	rsync $(RSYNC_OPTIONS) \
		deploy/ \
		$(RSYNC_DESTINATION)/

website.tar.gz: build history/git-history.jpg
	tar \
		--exclude-vcs \
		--format=gnu \
		--owner=0 --group=0 --numeric-owner \
		--sort=name \
		-czf \
		website.tar.gz \
		untitled/www/lbwww/site/ \
		history/git-history.dot \
		history/git-history.jpg \
		--transform="s#untitled/www/lbwww/site/##"
