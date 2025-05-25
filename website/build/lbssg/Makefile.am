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

################
# Status pages #
################

build/lbssg/0.1-rc1.md: $(STATUS_TABLE_0.1_RC1_DEPS) ../resources/data/0.1-rc1.rec
	status/generate-0.1-rc1-status-table.scm \
		--markdown \
		../resources/data/computers-0.1-rc1.rec \
		../resources/data/0.1-rc1.rec \
		"en" \
	> $@

build/lbssg/0.1-rc2.md: $(STATUS_TABLE_0.1_RC2_DEPS) ../resources/data/0.1-rc2.rec
	status/generate-0.1-rc1-status-table.scm \
		--markdown \
		../resources/data/computers-0.1-rc2.rec \
		../resources/data/0.1-rc2.rec \
		"en" \
	> $@

build/lbssg/0.1-rc3.md: $(STATUS_TABLE_0.1_RC2_DEPS) ../resources/data/0.1-rc3.rec
	status/generate-0.1-rc1-status-table.scm \
		--markdown \
		../resources/data/computers-0.1-rc2.rec \
		../resources/data/0.1-rc3.rec \
		"en" \
	> $@

build/lbssg/0.1-rc4.md: $(STATUS_TABLE_0.1_RC4_DEPS) ../resources/data/0.1-rc4.rec
	status/generate-0.1-rc4-status-table.scm \
		--markdown \
		../resources/data/computers-0.1-rc4.rec \
		../resources/data/0.1-rc4.rec \
		"en" \
	> $@

build/lbssg/0.1-rc5.md: $(STATUS_TABLE_0.1_RC4_DEPS) ../resources/data/0.1-rc5.rec
	status/generate-0.1-rc4-status-table.scm \
		--markdown \
		../resources/data/computers-0.1-rc4.rec \
		../resources/data/0.1-rc5.rec \
		"en" \
	> $@

build/lbssg/0.1-rc6.md: $(STATUS_TABLE_0.1_RC4_DEPS) ../resources/data/0.1-rc6.rec
	status/generate-0.1-rc4-status-table.scm \
		--markdown \
		../resources/data/computers-0.1-rc4.rec \
		../resources/data/0.1-rc6.rec \
		"en" \
	> $@

build/lbssg/0.1-rc1.es.md: $(STATUS_TABLE_0.1_RC1_DEPS) ../resources/data/0.1-rc1.rec
	status/generate-0.1-rc1-status-table.scm \
		--markdown \
		../resources/data/computers-0.1-rc1.rec \
		../resources/data/0.1-rc1.rec \
		"es" \
	> $@

build/lbssg/0.1-rc2.es.md: $(STATUS_TABLE_0.1_RC2_DEPS) ../resources/data/0.1-rc2.rec
	status/generate-0.1-rc1-status-table.scm \
		--markdown \
		../resources/data/computers-0.1-rc2.rec \
		../resources/data/0.1-rc2.rec \
		"es" \
	> $@

build/lbssg/0.1-rc3.es.md: $(STATUS_TABLE_0.1_RC2_DEPS) ../resources/data/0.1-rc3.rec
	status/generate-0.1-rc1-status-table.scm \
		--markdown \
		../resources/data/computers-0.1-rc2.rec \
		../resources/data/0.1-rc3.rec \
		"es" \
	> $@

build/lbssg/0.1-rc4.es.md: $(STATUS_TABLE_0.1_RC4_DEPS) ../resources/data/0.1-rc4.rec
	status/generate-0.1-rc4-status-table.scm \
		--markdown \
		../resources/data/computers-0.1-rc4.rec \
		../resources/data/0.1-rc4.rec \
		"es" \
	> $@

build/lbssg/0.1-rc5.es.md: $(STATUS_TABLE_0.1_RC4_DEPS) ../resources/data/0.1-rc5.rec
	status/generate-0.1-rc4-status-table.scm \
		--markdown \
		../resources/data/computers-0.1-rc4.rec \
		../resources/data/0.1-rc5.rec \
		"es" \
	> $@

build/lbssg/0.1-rc6.es.md: $(STATUS_TABLE_0.1_RC4_DEPS) ../resources/data/0.1-rc6.rec
	status/generate-0.1-rc4-status-table.scm \
		--markdown \
		../resources/data/computers-0.1-rc4.rec \
		../resources/data/0.1-rc6.rec \
		"es" \
	> $@

build/lbssg/coreboot-upstream-status.md: $(COREBOOT_UPSTREAM_STATUS_TABLE_DEPS)
	status/generate-coreboot-upstream-status.scm \
		--markdown \
		../resources/data/coreboot-upstream-status.rec \
		"en" \
		> $@

build/lbssg/coreboot-upstream-status.es.md: $(COREBOOT_UPSTREAM_STATUS_TABLE_DEPS)
	status/generate-coreboot-upstream-status.scm \
		--markdown \
		../resources/data/coreboot-upstream-status.rec \
		"es" \
		> $@

build/lbssg/upstream-versions.md: $(UPSTREAM_VERSIONS_TABLE_DEPS)
	status/generate-upstream-versions.scm \
		--markdown \
		../resources/data/upstream-versions.rec \
		"en" \
		> $@

build/lbssg/upstream-versions.es.md: $(UPSTREAM_VERSIONS_TABLE_DEPS)
	status/generate-upstream-versions.scm \
		--markdown \
		../resources/data/upstream-versions.rec \
		"es" \
		> $@

build/lbssg/reproducible-builds-status.md: $(REPRODUCIBLE_BUILDS_STATUS_TABLE_DEPS)
	status/generate-reproducible-builds-status.scm \
		--markdown \
		../resources/data/reproducible-builds-status.rec \
		"en" \
		> $@

build/lbssg/reproducible-builds-status.es.md: $(REPRODUCIBLE_BUILDS_STATUS_TABLE_DEPS)
	status/generate-reproducible-builds-status.scm \
		--markdown \
		../resources/data/reproducible-builds-status.rec \
		"es" \
		> $@

STATUS_PAGE_DEPS = \
	build/lbssg/0.1-rc1.md \
	build/lbssg/0.1-rc2.md \
	build/lbssg/0.1-rc3.md \
	build/lbssg/0.1-rc4.md \
	build/lbssg/0.1-rc5.md \
	build/lbssg/0.1-rc6.md \
	build/lbssg/coreboot-upstream-status.md \
	build/lbssg/reproducible-builds-status.md \
	build/lbssg/status.py \
	build/lbssg/upstream-versions.md \
	status/status.md.tmpl \
$(SENTINEL)

ES_STATUS_PAGE_DEPS = \
	build/lbssg/0.1-rc1.es.md \
	build/lbssg/0.1-rc2.es.md \
	build/lbssg/0.1-rc3.es.md \
	build/lbssg/0.1-rc4.es.md \
	build/lbssg/0.1-rc5.es.md \
	build/lbssg/0.1-rc6.es.md \
	build/lbssg/coreboot-upstream-status.es.md \
	build/lbssg/reproducible-builds-status.es.md \
	build/lbssg/status.py \
	build/lbssg/upstream-versions.es.md \
	status/status.es.md.tmpl \
	$(SENTINEL)

build/lbssg/status.md: $(STATUS_PAGE_DEPS)
	python3 build/lbssg/status.py en > $@

build/lbssg/status.es.md: $(ES_STATUS_PAGE_DEPS)
	python3 build/lbssg/status.py es > $@

LBSSG_GENERATED_STATUS_PAGES = \
	build/lbssg/status.md \
	build/lbssg/status.es.md \
	$(SENTINEL)

LBSSG_BUILD_DEPS = \
	templates/site.cfg \
	templates/footer.include \
	$(GNUBOOT_MANUAL) \
	$(LBSSG_GENERATED_STATUS_PAGES)

####################
# End status pages #
####################

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

lbssg-check: lbssg-build lbssg-website.tar
	$(CHECK_SH_CMD) --website-prefix $(WEBSITE_PREFIX) \
		--tarball lbssg-website.tar
