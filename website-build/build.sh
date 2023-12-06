#!/usr/bin/env bash
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

# For compatibility with sysexits.h (see man 3 sysexits.h for more details)
EX_USAGE=64

untitled_uri="https://notabug.org/untitled/untitled.git"
untitled_path=""
untitled_commit="a147a4303b5608db8fde08abd08b7cc21f1a0c03"
untitled_patches=" \
	patches/0001-Enable-to-deploy-websites-in-subdirectories.patch \
"
help()
{
	echo "Usage: $0 [options]"
	echo ""
	echo "Available options:"
	echo -e "\t-h, --help"
	echo -e "\t\tDisplay this help and exit."
	echo -e "\t--with-untitled-path PATH"
	echo -e "\t\tUse a local untitled directory from PATH\n" \
	     "\t\tinstead of downloading the latest version from\n" \
	     "\t\t${untitled_uri}"
	echo -e "\t--download-only"
	echo -e "\t\tOnly download and setup Untitled. Does not build the"
	echo -e "\t\twebsite."

}

sync_repo()
{
	dst_path="$1"
	src_uri="$2"
	src_path="$3"
	src_revision="$4"
	src_patches="$5"

	if [ -z "${src_path}" ] && [ ! -d "${dst_path}" ] ; then
		git clone "${src_uri}" "${dst_path}"
		git -C "${dst_path}" checkout "${src_revision}"
	elif [ ! -d "${dst_path}" ] ; then
		mkdir -p "$(dirname ${dst_path})"
		cp -a "${src_path}" "${dst_path}"
		if [ -n "${src_revision}" ] ; then
			git -C "${dst_path}" checkout "${src_revision}"
		fi
	elif [ -z "${src_path}" ] ; then
		localrev="$(git -C "${dst_path}" --no-pager \
				log --oneline HEAD -1 --format='%H')"

		git -C "${dst_path}" remote get-url origin || \
		    git -C "${dst_path}" remote add origin "${src_uri}"
		git -C "${dst_path}" remote set-url origin "${src_uri}"
		git -C "${dst_path}" clean -dfx

		if [ "${localrev}" != "${src_revision}" ] ; then
			git -C "${dst_path}" fetch origin
			git -C "${dst_path}" checkout "${src_revision}"
		fi



		if git -C "${dst_path}"  status | \
			grep '^rebase in progress;' > /dev/null ; then
			git -C "${dst_path}" am --abort
		fi

		for patch in ${src_patches} ; do
			GIT_COMMITTER_EMAIL="noreply@gnuboot.gnu.org" \
			GIT_COMMITTER_NAME="website-build" \
			git -C "${dst_path}" am $(realpath ${patch})
		done
	else
		rm -rf "${dst_path}"
		cp -a "${src_path}" "${dst_path}"
		if [ -n "${src_revision}" ] ; then
			git -C "${dst_path}" checkout "${src_revision}"
		fi
	fi
}

copy_website()
{
	dst_path="$1"

	rm -rf "${dst_path}"
	mkdir -p "${dst_path}"
	cp "../site.cfg" "${dst_path}"
	cp -a "../site/" "${dst_path}"
}

help_missing_arg()
{
	printf "Error: Argument of %s is missing.\n\n" "$1"
	help
}

download_only=0
i=1
while [ "$i" -le $# ] ; do
	opt="$(eval echo \$$i)"

	case "${opt}" in
		-h|--help)
			help
			exit 0
			;;
		--download-only)
			download_only=1
			;;
		--with-untitled-path)
			if [ "$i" -ge $# ] ; then
				help_missing_arg "--with-untitled-path"
				exit ${EX_USAGE}
			fi
			untitled_path="$(eval echo \$$(expr $i + 1))"
			i="$(expr "$i" + 1)"
			;;
		*)
			help
			exit ${EX_USAGE}
			;;
	esac

	i="$(expr "$i" + 1)"
done

set -e

sync_repo "untitled" \
	  "${untitled_uri}" "${untitled_path}" \
	  "${untitled_commit}" "${untitled_patches}"

if [ "${download_only}" -eq 0 ] ; then
	copy_website "untitled/www/lbwww/"

	cd untitled
	./build sites lbwww
fi
