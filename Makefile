# Copyright (C) 2022 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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
DOMAIN := gnutoo.srht.site

.PHONY: all build help upload website.tar.gz

all: website.tar.gz

build:
	guix shell \
		--container \
		--network \
		--emulate-fhs \
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

help:
	@printf "%s\n\t%s\n\t%s\n\t%s\n" \
		"Available commands:" \
		"help           # Print this help" \
		"upload         # Upload the website to https://$(DOMAIN)" \
		"website.tar.gz # Create a tarball of the website"

upload: website.tar.gz
	curl \
		--oauth2-bearer `cat id_oauth2_bearer` \
		-Fcontent=@website.tar.gz \
		https://pages.sr.ht/publish/$(DOMAIN)

index.html: index.html.tmpl
	sed 's/DOMAIN/$(DOMAIN)/' $? > $@

# See https://reproducible-builds.org/docs/archives/ for more details
website.tar.gz: build index.html
	sed 's/DOMAIN/$(DOMAIN)/' index.html.tmpl > index.html
	tar \
		--format=gnu \
		--mtime='1970-01-01 00:00Z' \
		--owner=0 --group=0 --numeric-owner \
		--sort=name \
		-czf \
		website.tar.gz \
		untitled/www/lbwww/site/ \
		index.html \
		 --transform="s#untitled/www/lbwww/site/#libreboot/#" \
