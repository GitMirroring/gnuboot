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

templates/site.cfg: templates/site.cfg.tmpl
	sed -e "s#WEBSITE_PREFIX#$(WEBSITE_PREFIX)#g" "$^" > "$@"

if WANT_GUIX
LBSSG_BUILD_CMD = $(GUIX_SHELL_CONTAINER) \
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
	build/lbssg/build.sh
else
LBSSG_BUILD_CMD = build/lbssg/build.sh
endif

LBSSG_BUILD_DEPS = \
	templates/site.cfg \
	templates/footer.include \
	$(GNUBOOT_MANUAL) \
	$(GENERATED_STATUS_PAGES)

lbssg-build: $(LBSSG_BUILD_DEPS)
	$(LBSSG_BUILD_CMD) $(BUILD_OPTIONS)

lbssg-website.tar: lbssg-build $(WEBSITE_TAR_GZ_DEPS)
	tar \
		--exclude-vcs \
		--format=gnu \
		--owner=0 --group=0 --numeric-owner \
		--sort=name \
		-cf \
		$@ \
		build/lbssg/site/www/lbwww/site/ \
		history/git-history.dot \
		history/git-history.jpg \
		$(WEB_SYMLINKS_FILES) \
		$(WEB_SYMLINKS_TRANSFORM) \
		--transform="s#build/lbssg/site/www/lbwww/site/##" \
		$(SENTINEL)

if ! WANT_LIGHTTPD
lbssg-serve:
	@printf "%s %s\n" \
		"The $@ target is disabled." \
		"To enable it, run './configure --enable-lighttpd'."
	@false
else
lbssg-serve: lbssg-website.tar
	$(SERVE_SH_CMD) --website-prefix $(WEBSITE_PREFIX) \
			lbssg-website.tar $(LIGHTTPD_PORT)
endif

lbssg-website-pretty-html.tar: build/prettify-archive.py lbssg-website.tar
	$(PRETTIFY_ARCHIVE_PY) lbssg-website.tar $@

lbssg-check: lbssg-build lbssg-website.tar history/git-history.jpg
	$(CHECK_SH_CMD) --website-prefix $(WEBSITE_PREFIX) \
		--tarball lbssg-website.tar
