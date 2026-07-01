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

if WANT_GENERATE_LOCALES
SET_LOCPATH = export LOCPATH=locale ;
LOCALE_DEPS = $(LOCALES)
PRESERVE_LOCPATH = --preserve="^LOCPATH$$"
else # WANT_GENERATE_LOCALES
SET_LOCPATH =
LOCPATH =
LOCALE_DEPS =
endif # WANT_GENERATE_LOCALES

if WANT_GUIX
# The --expose is for enabling git to retrieve the commit hash and subject.
# And since we're using Guix 1.4.0, we can't simply use the glibc's C.UTF-8
# builtin locale, and we need guile to be able to use UTF-8 locales in order
# for haunt to properly handle UTF-8 markdown files.
HAUNT_BUILD_CMD = \
	$(GUIX_SHELL_CONTAINER) \
	--share=`realpath ..` \
	bash \
	git \
	glibc-locales \
	haunt \
	-- \
	haunt build
else
HAUNT_BUILD_CMD = $(LOCPATH) haunt build
endif

build/haunt/0.1-rc1.html: $(STATUS_TABLE_0.1_RC1_DEPS) ../resources/data/0.1-rc1.rec
	status/generate-0.1-rc1-status-table.scm \
		--html \
		../resources/data/computers-0.1-rc1.rec \
		../resources/data/0.1-rc1.rec \
		"en" \
	> $@.tmp
	sed 's/ *$$//'g $@.tmp > $@

build/haunt/0.1-rc2.html: $(STATUS_TABLE_0.1_RC2_DEPS) ../resources/data/0.1-rc2.rec
	status/generate-0.1-rc1-status-table.scm \
		--html \
		../resources/data/computers-0.1-rc2.rec \
		../resources/data/0.1-rc2.rec \
		"en" \
	> $@

build/haunt/0.1-rc3.html: $(STATUS_TABLE_0.1_RC2_DEPS) ../resources/data/0.1-rc3.rec
	status/generate-0.1-rc1-status-table.scm \
		--html \
		../resources/data/computers-0.1-rc2.rec \
		../resources/data/0.1-rc3.rec \
		"en" \
	> $@

build/haunt/0.1-rc4.html: $(STATUS_TABLE_0.1_RC4_DEPS) ../resources/data/0.1-rc4.rec
	status/generate-0.1-rc4-status-table.scm \
		--html \
		../resources/data/computers-0.1-rc4.rec \
		../resources/data/0.1-rc4.rec \
		"en" \
	> $@

build/haunt/0.1-rc5.html: $(STATUS_TABLE_0.1_RC4_DEPS) ../resources/data/0.1-rc5.rec
	status/generate-0.1-rc4-status-table.scm \
		--html \
		../resources/data/computers-0.1-rc4.rec \
		../resources/data/0.1-rc5.rec \
		"en" \
	> $@

build/haunt/0.1-rc6.html: $(STATUS_TABLE_0.1_RC4_DEPS) ../resources/data/0.1-rc6.rec
	status/generate-0.1-rc4-status-table.scm \
		--html \
		../resources/data/computers-0.1-rc4.rec \
		../resources/data/0.1-rc6.rec \
		"en" \
	> $@

build/haunt/coreboot-upstream-status.html: $(COREBOOT_UPSTREAM_STATUS_TABLE_DEPS)
	status/generate-coreboot-upstream-status.scm \
		--html \
		../resources/data/coreboot-upstream-status.rec \
		"en" \
		> $@

build/haunt/upstream-versions.html: $(UPSTREAM_VERSIONS_TABLE_DEPS)
	status/generate-upstream-versions.scm \
		--html \
		../resources/data/upstream-versions.rec \
		"en" \
		> $@

build/haunt/reproducible-builds-status.html: $(REPRODUCIBLE_BUILDS_STATUS_TABLE_DEPS)
	status/generate-reproducible-builds-status.scm \
		--html \
		../resources/data/reproducible-builds-status.rec \
		"en" \
		> $@

HAUNT_STATUS_PAGE_DEPS = \
	build/haunt/0.1-rc1.html \
	build/haunt/0.1-rc2.html \
	build/haunt/0.1-rc3.html \
	build/haunt/0.1-rc4.html \
	build/haunt/0.1-rc5.html \
	build/haunt/0.1-rc6.html \
	build/haunt/coreboot-upstream-status.html \
	build/haunt/upstream-versions.html \
	build/haunt/reproducible-builds-status.html \
	build/haunt/status.py \
	status/status.md.tmpl \
$(SENTINEL)

# We want the template file to then substitute the table with HTML
# generated with Guile.
pages/status.md: status/status.md.tmpl
	install -m 644 $^ $@

pages/status.es.md: status/status.es.md.tmpl
	install -m 644 $^ $@

HAUNT_STATUS_PAGES = \
	pages/status.es.md \
	$(SENTINEL)

HAUNT_BUILD_DEPS = \
	pages/status.md \
	pages/status.es.md \
	templates/site.cfg \
	templates/footer.include \
	$(GNUBOOT_MANUAL) \
	$(HAUNT_STATUS_PAGES)

haunt-build: $(HAUNT_BUILD_DEPS) $(HAUNT_STATUS_PAGE_DEPS) $(LOCALE_DEPS)
	$(HAUNT_BUILD_CMD)
	find build/haunt/site/software/gnuboot/ \
		-name "*.html" -type f \
		-exec build/haunt/fixup-comments.sh '{}' \;
	python3 build/haunt/status.py en

haunt-website.tar: haunt-build history/git-history.jpg $(WEB_SYMLINKS_FILES)
	find build/haunt/site -type d -empty -delete
	tar \
		--exclude-vcs \
		--format=gnu \
		--owner=0 --group=0 --numeric-owner \
		--sort=name \
		-cf \
		$@ \
		build/haunt/site \
		history/git-history.dot \
		history/git-history.jpg \
		$(WEB_SYMLINKS_FILES) \
		$(WEB_SYMLINKS_TRANSFORM) \
		--transform="s#build/haunt/site/software/gnuboot/##" \
		$(SENTINEL)

if ! WANT_LIGHTTPD
haunt-serve:
	@printf "%s %s\n" \
		"The $@ target is disabled." \
		"To enable it, run './configure --enable-lighttpd'."
	@false
else
haunt-serve: haunt-website.tar
	$(SERVE_SH_CMD) --website-prefix $(WEBSITE_PREFIX) \
			haunt-website.tar $(LIGHTTPD_PORT)
endif # WANT_LIGHTTPD

haunt-website-pretty-html.tar: build/prettify-archive.py haunt-website.tar
	$(PRETTIFY_ARCHIVE_PY) haunt-website.tar $@

HAUNT_CHECK_TMPDIR = build/haunt/check
haunt-check: haunt-build haunt-website.tar
	rm -rf $(HAUNT_CHECK_TMPDIR)
	mkdir -p $(HAUNT_CHECK_TMPDIR)/$(WEBSITE_PREFIX)
	tar xf lbssg-website.tar -C $(HAUNT_CHECK_TMPDIR)/$(WEBSITE_PREFIX)
	$(CHECK_SH_CMD) --website-prefix $(WEBSITE_PREFIX) \
		--directory $(HAUNT_CHECK_TMPDIR)
