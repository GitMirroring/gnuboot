# Copyright (C) 2023,2024 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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

# This Makefile makes it easier to cache the builds than with shell
# scripts: The make program compares the timestamps of the source code
# and the binaries and if the source is more recent, rebuilds the
# binaries.

TOPDIR = .

DESTDIR ?= $(TOPDIR)/release

PACK_NAME = i945-thinkpads-install-utilities

GUIX_PACKAGE_NAMES ?= bucts flashrom-bucts
RELEASE_DIR = $(DESTDIR)/i945-thinkpads-install

# We enable caching by not making this configurable and so when the
# Makefile isn't updated, the Guix revision doesn't change, so we
# don't need to rebuild anything.

GUIX_PACK_COMMAND = \
	source $(TOPDIR)/config.sh && \
	source resources/scripts/misc/guix.sh && \
	source_guix_profile && \
	guix time-machine \
	--commit="$${GUIX_REVISION}" -- \
	pack \
	-L $(TOPDIR)/resources/guix/ \
	-L $(TOPDIR)/resources/guix/gnuboot/patches/ \
	-RR \
	--save-provenance \
	--system=i686-linux \
	--symlink=/usr/local/bin/bucts=bin/bucts \
	--symlink=/usr/local/bin/flashrom-bucts=sbin/flashrom-bucts

.PHONY: $(PACK_NAME) $(PACK_NAME)-clean $(PACK_NAME)-distclean $(PACK_NAME)-download $(PACK_NAME)-module

$(PACK_NAME): \
	$(RELEASE_DIR)/$(PACK_NAME)-deb-pack.deb \
	$(RELEASE_DIR)/$(PACK_NAME)-tarball-pack.tar.gz \
	$(RELEASE_DIR)/packages_src.tar \
	$(RELEASE_DIR)/gnuboot_src.tar

# To better fit in the current package structure
$(PACK_NAME)-download: $(PACK_NAME)
$(PACK_NAME)-module: $(PACK_NAME)

# TODO: Make sure the tarball is reproducible
$(RELEASE_DIR)/gnuboot_src.tar:  Makefile
	install -d $(RELEASE_DIR)
	git -C $(TOPDIR) archive HEAD > $@

# TODO: Use Guix to produce a source package to make it reproducible
$(RELEASE_DIR)/packages_src.tar:  Makefile
	install -d $(RELEASE_DIR)
	tar cf $@ \
		`source $(TOPDIR)/config.sh && \
		source resources/scripts/misc/guix.sh && \
		source_guix_profile && \
		guix time-machine --commit="$${GUIX_REVISION}" -- \
		build \
		-c $(GUIX_BUILD_MAX_CORES) \
		-L $(TOPDIR)/resources/guix/ \
		-L $(TOPDIR)/resources/guix/gnuboot/patches \
		--sources=transitive \
		$(GUIX_PACKAGE_NAMES) | sort -u`

$(RELEASE_DIR)/$(PACK_NAME)-deb-pack.deb: Makefile
	install -d $(RELEASE_DIR)
	install \
	`$(GUIX_PACK_COMMAND) --format="deb" $(GUIX_PACKAGE_NAMES)` \
	$@

$(RELEASE_DIR)/$(PACK_NAME)-tarball-pack.tar.gz: Makefile
	install -d $(RELEASE_DIR)
	install \
	`$(GUIX_PACK_COMMAND) --format="tarball" $(GUIX_PACKAGE_NAMES)` \
	$@

$(PACK_NAME)-clean:
	rm -rf $(RELEASE_DIR)

$(PACK_NAME)-distclean: $(PACK_NAME)-clean

$(PACK_NAME)-help:
	@printf "$(PACK_NAME) related commands:\n"
	@printf "\t%s %s\n"                     \
		"make $(PACK_NAME)           #" \
		"Build and relese $(PACK_NAME)."
	@printf "\t%s %s\n"                     \
		"make $(PACK_NAME)-clean     #" \
		"Remove all the built files related to the target."
	@printf "\t%s %s\n"                     \
		"make $(PACK_NAME)-distclean #" \
		"Alias to $(PACK_NAME)-clean for compatibility."
	@printf "\t%s %s\n"                     \
		"make $(PACK_NAME)-download  #" \
		"Alias to $(PACK_NAME) for compatibility."
	@printf "\t%s %s\n"                     \
		"make $(PACK_NAME)-module    #" \
		"Alias to $(PACK_NAME) for compatibility."

	@printf "\t%s %s\n"                              \
		"make $(RELEASE_DIR)/gnuboot_src.tar  #" \
		"Release the GNU Boot source code."
	@printf "\t%s %s\n"                              \
		"make $(RELEASE_DIR)/packages_src.tar #" \
		"Relase the source code corresponding to the package binaries."
	@printf "\t%s %s\n"                                              \
		"make $(RELEASE_DIR)/$(PACK_NAME)-deb-pack.deb        #" \
		"Release a Debian package of the binaries."
	@printf "\t%s %s\n"                                              \
		"make $(RELEASE_DIR)/$(PACK_NAME)-tarball-pack.tar.gz #" \
		"Release a tarball of the binaries."
