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

if WANT_GUIX
# The --expose is for enabling git to retrieve the commit hash and subject.
# And since we're using Guix 1.4.0, we can't simply use the glibc's C.UTF-8
# builtin locale, and we need guile to be able to use UTF-8 locales in order
# for haunt to properly handle UTF-8 markdown files.
HAUNT_BUILD_CMD = \
	$(GUIX_SHELL_CONTAINER) \
	--share=`realpath ..` \
	--preserve='^GUIX_LOCPATH$$' \
	bash \
	git \
	glibc-locales \
	haunt \
	-- \
	bash -ic 'GUIX_LOCPATH="$$GUIX_ENVIRONMENT/lib/locale" haunt build'
else
HAUNT_BUILD_CMD = haunt build
endif

haunt-build: $(GNUBOOT_MANUAL)
	$(HAUNT_BUILD_CMD)
	find build/haunt/site/software/gnuboot/ \
		-name "*.html" -type f \
		-exec build/haunt/fixup-comments.sh '{}' \;

haunt-website.tar: haunt-build history/git-history.jpg
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
haunt-check: haunt-build haunt-website.tar history/git-history.jpg
	rm -rf $(HAUNT_CHECK_TMPDIR)
	mkdir -p $(HAUNT_CHECK_TMPDIR)/$(WEBSITE_PREFIX)
	tar xf lbssg-website.tar -C $(HAUNT_CHECK_TMPDIR)/$(WEBSITE_PREFIX)
	$(CHECK_SH_CMD) --website-prefix $(WEBSITE_PREFIX) \
		--directory $(HAUNT_CHECK_TMPDIR)
