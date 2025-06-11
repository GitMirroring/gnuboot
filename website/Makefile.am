# Copyright (C) 2022-2025 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
# Copyright (C) 2025 Adrien 'neox' Bourmault <neox@gnu.org>
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

.PHONY: \
	all \
	build \
	check \
	help \
	publish \
	serve \
	website-raw.tar.gz \
if WANT_WEB_SYMLINKS_PATH
	$(WEB_SYMLINKS_PATH)/COPYING \
	$(WEB_SYMLINKS_PATH)/web-symlinks \
endif
	$(SENTINEL)

all: help

BUILD_OPTIONS :=
GUIX_SHARE_OPTIONS := --share=`realpath ../`

############
# Untitled #
############

if WANT_UNTITLED_PATH
BUILD_OPTIONS += --with-untitled-path $(UNTITLED_PATH)
GUIX_SHARE_OPTIONS += --share=`realpath $(UNTITLED_PATH)`
endif

################
# web-symlinks #
################
symlinks/symlinks.txt:
	echo ". web" >> $@

# This enables to use a modified version of web-symlinks or use it
# offline if we have it downloaded somewhere.
if WANT_WEB_SYMLINKS_PATH
GUIX_SHARE_OPTIONS += --share=`realpath $(WEB_SYMLINKS_PATH)`

# With ./configure --with-untitled-path=[...], we end up having a
# specific revision that is set in build.sh. So here we also verify
# the checksums for consistency.

$(WEB_SYMLINKS_PATH)/COPYING.sha512: symlinks/COPYING.sha512
	echo "`cat $^ | awk '{print $$1}'` `echo $@ | sed 's/\.sha512$$//'`" > $@

$(WEB_SYMLINKS_PATH)/web-symlinks.sha512: symlinks/web-symlinks.sha512
	echo "`cat $^ | awk '{print $$1}'` `echo $@ | sed 's/\.sha512$$//'`" > $@

$(WEB_SYMLINKS_PATH)/COPYING: $(WEB_SYMLINKS_PATH)/COPYING.sha512
	sha512sum --strict -c $^

$(WEB_SYMLINKS_PATH)/web-symlinks: $(WEB_SYMLINKS_PATH)/web-symlinks.sha512
	sha512sum --strict -c $^

WEB_SYMLINKS_FILES = \
	symlinks/symlinks.txt \
	$(WEB_SYMLINKS_PATH)/COPYING \
	$(WEB_SYMLINKS_PATH)/web-symlinks \
	$(SENTINEL)

# For the second transform, we need to remove the leading / as tar
# already removes it when adding the $(WEB_SYMLINKS_PATH)/* files
# (tar: Removing leading `/' from member names) and so if we don't
# remove it from the transform argument, we end up with a substitution
# that doesn't work.
WEB_SYMLINKS_TRANSFORM = \
	--transform='s%symlinks/symlinks.txt%.symlinks%' \
	--transform="s%`echo $(WEB_SYMLINKS_PATH) | sed 's%^/%%'`%web-symlinks%" \
	$(SENTINEL)
else
symlinks/web-symlinks/web-symlinks: symlinks/web-symlinks.sha512
	mkdir -p symlinks/web-symlinks
	sha512sum --status --quiet --strict -c $^ || cvs \
		-f \
		-d:pserver:anonymous@cvs.savannah.gnu.org:/sources/www \
		co -d symlinks/web-symlinks www/symlinks/web-symlinks
	@sha512sum --strict -c $^

symlinks/web-symlinks/COPYING: symlinks/COPYING.sha512
	mkdir -p symlinks/web-symlinks
	sha512sum --status --quiet --strict -c $^ || cvs \
		-f \
		-d:pserver:anonymous@cvs.savannah.gnu.org:/sources/www \
		co -d symlinks/web-symlinks www/symlinks/COPYING
	@sha512sum --strict -c $^

WEB_SYMLINKS_FILES = \
	symlinks/symlinks.txt \
	symlinks/web-symlinks/COPYING \
	symlinks/web-symlinks/web-symlinks \
	$(SENTINEL)

WEB_SYMLINKS_TRANSFORM = \
	--transform='s%symlinks.txt%.symlinks%' \
	--transform='s%symlinks/%%' \
	$(SENTINEL)
endif

GUIX_SHELL_CONTAINER = \
	$(srcdir)/../resources/wrapper/guix \
	shell \
	--system=i686-linux \
	--container \
	`$(srcdir)/../resources/wrapper/guix \
		repl force-bordeaux-substitute.scm force` \
	$(SENTINEL)

###########
# history #
###########

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

#############
# templates #
#############

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

##########
# manual #
##########

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

../manual/build-guix-%-linux.sh: ../manual/build-guix-%-linux.sh.in
	m4 -DGUIX_REVISION=$(GUIX_REVISION) $^ | \
		sed 's/#.*//' | \
		sed '/^$$/d' > $@
	chmod +x $@

../manual/guix-revision.texi:
	../../$(srcdir)/guix-revision.sh print-texinfo > $@

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
	../manual/build-guix-i686-linux.sh \
	../manual/build-guix-x86_64-linux.sh \
	../manual/fdl-1.3.texi \
	../manual/gnuboot.texi \
	../manual/guix-revision.texi \
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

#################
# website build #
#################

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

###################
# automatic tests #
###################

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

################
# manual tests #
################

if WANT_GUIX
SERVE_SH_CMD = $(GUIX_SHELL_CONTAINER) \
	--network \
	--emulate-fhs \
	bash \
	coreutils \
	findutils \
	gzip \
	lighttpd \
	perl \
	perl-uri \
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

##########################
# publishing the website #
##########################

RSYNC_OPTIONS := -av --progress --delete
publish: website.tar.gz
	rm -rf deploy
	mkdir -p deploy
	tar xf website.tar.gz -C deploy
	rsync $(RSYNC_OPTIONS) \
		deploy/ \
		$(RSYNC_DESTINATION)/

###################
# website tarball #
###################

WEBSITE_TAR_GZ_DEPS = \
	history/git-history.jpg \
	$(WEB_SYMLINKS_FILES) \
	$(SENTINEL)

website-raw.tar.gz: build $(WEBSITE_TAR_GZ_DEPS)
	tar \
		--exclude-vcs \
		--format=gnu \
		--owner=0 --group=0 --numeric-owner \
		--sort=name \
		-czf \
		$@ \
		untitled/www/lbwww/site/ \
		history/git-history.dot \
		history/git-history.jpg \
		$(WEB_SYMLINKS_FILES) \
		$(WEB_SYMLINKS_TRANSFORM) \
		--transform="s#untitled/www/lbwww/site/##" \
		$(SENTINEL)

if WANT_GUIX
PRETTIFY_ARCHIVE_PY = \
	$(GUIX_SHELL_CONTAINER) \
	python python-beautifulsoup4 -- python3 prettify-archive.py
else
PRETTIFY_ARCHIVE_PY = python3 prettify-archive.py
endif

website.tar.gz: website-raw.tar.gz
	$(PRETTIFY_ARCHIVE_PY) $^ $@
