#!/bin/bash
#
# Copyright (C) 2023 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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

topdir="$(dirname "$(dirname "$(dirname "$(dirname "$0")")")")"

true=0
false=1

# shellcheck disable=SC2034
guix_v0_0="6365068393254e1131ab80eb0d68a759e7fd2256"
# shellcheck disable=SC2034
guix_v0_1="a1ba8475a610fd491be4e512e599515f36d8b109"
# shellcheck disable=SC2034
guix_v0_2="e8b3afeb9234bca4a455272a6a831d7994d29b96"
# shellcheck disable=SC2034
guix_v0_3="3253830d46cc55dd6b946468edd6a6f72944ef48"
# shellcheck disable=SC2034
guix_v0_4="81bb9b6665e253c42b078e752ec01020b7434e3f"
# shellcheck disable=SC2034
guix_v0_5="5d6dbd299e8389e8eb918daac00df9b6f6835e14"
# shellcheck disable=SC2034
guix_v0_6="4ec91959f2d13188894e45f82bf7b8c1c4ea7f4a"
# shellcheck disable=SC2034
guix_v0_7="508ea01ef20652fb2de875d1d91c27f5178e2874"
# shellcheck disable=SC2034
guix_v0_8="44941798d222901b8f381b3210957d880b90a2fc"
# shellcheck disable=SC2034
guix_v0_8_1="983c082a747c76bfefcfa0258d804f94c1f5afed"
# shellcheck disable=SC2034
guix_v0_8_2="04bdcdb6365e588aa8037a6c02d424b4eed6e2a9"
# shellcheck disable=SC2034
guix_v0_8_3="e348eaaf318646e259a5e6803133ad5b296febc1"
# shellcheck disable=SC2034
guix_v0_9_0="c8855b991880897b2658dc90164e29c96e2aeb3a"
# shellcheck disable=SC2034
guix_v0_10_0="34bf416e4a61324db80c5cea4ea5463f687057f9"
# shellcheck disable=SC2034
guix_v0_11_0="66edac525b7bb8ba29362c887450ff38c54da08d"
# shellcheck disable=SC2034
guix_v0_12_0="a81771f137716c62e7a44355e18ce5487ecf5301"
# shellcheck disable=SC2034
guix_v0_13_0="df671177f854da26bb171d9d5e9a6990024107a0"
# shellcheck disable=SC2034
guix_v0_14_0="40f5c53d89da266055a1dd6571c380f5c57fe5f9"
# shellcheck disable=SC2034
guix_v0_15_0="359fdda40f754bbf1b5dc261e7427b75463b59be"
# shellcheck disable=SC2034
guix_v0_16_0="4a0b87f0ec5b6c2dcf82b372dd20ca7ea6acdd9c"
# shellcheck disable=SC2034
guix_v1_0_0="6298c3ffd9654d3231a6f25390b056483e8f407c"
# shellcheck disable=SC2034
guix_v1_0_1="d68de958b60426798ed62797ff7c96c327a672ac"
# shellcheck disable=SC2034
guix_v1_1_0="d62c9b2671be55ae0305bebfda17b595f33797f2"
# shellcheck disable=SC2034
guix_v1_2_0="a099685659b4bfa6b3218f84953cbb7ff9e88063"
# shellcheck disable=SC2034
guix_v1_3_0="a0178d34f582b50e9bdbb0403943129ae5b560ff"
# shellcheck disable=SC2034
guix_v1_4_0="8e2f32cee982d42a79e53fc1e9aa7b8ff0514714"

guix_known_versions=" \
    0.0 \
    0.1 \
    0.2 \
    0.3 \
    0.4 \
    0.5 \
    0.6 \
    0.7 \
    0.8 \
    0.8.1 \
    0.8.2 \
    0.8.3 \
    0.9.0 \
    0.10.0 \
    0.11.0 \
    0.12.0 \
    0.13.0 \
    0.14.0 \
    0.15.0 \
    0.16.0 \
    1.0.0 \
    1.0.1 \
    1.1.0 \
    1.1.0rc1 \
    1.1.0rc2 \
    1.2.0 \
    1.2.0rc1 \
    1.2.0rc2 \
    1.3.0 \
    1.3.0rc1 \
    1.3.0rc2 \
    1.4.0 \
    1.4.0rc1 \
    1.4.0rc2 \
"

guix_latest_release="1.4.0"

source_guix_profile()
{
    if [ -f "${HOME}"/.config/guix/current/etc/profile ] ; then
        GUIX_PROFILE="${HOME}/.config/guix/current"

        # For some reasons using "# shellcheck
        # source=${HOME}/.config/guix/current/etc/profile" doesn't
        # work, so we need to tell shellcheck not to test that file.
        # shellcheck disable=SC1091
        . "$GUIX_PROFILE"/etc/profile
    fi
}

guix_version()
{
    guix --version | grep '^guix (GNU Guix)' | awk '{print $4}'
}

guix_version_commit()
{
    version="$1"

    eval echo "\$guix_""${version//./_}"
}

is_guix_system()
{
    grep "ID=guix" /etc/os-release > /dev/null && return ${true}
    return ${false}
}

is_known_version()
{
    version="$1"

    for known_version in ${guix_known_versions} ; do
        if [ "${version}" = "${known_version}" ] ; then
            return ${true}
        fi
    done

    return ${false}
}


is_rc_version()
{
    version="$1"
    echo "${version}" | grep "rc[0-9]\+$" > /dev/null
}

commit_contains_last_release()
{
    commit="$1"

    "${topdir}"/resources/git/git \
        -C "$(guix_checkout)" \
        tag \
        --sort=taggerdate \
        --merged "${commit}" | \
        grep '^v[0-9]' | \
        sed 's#^v##' |\
        grep "^${guix_latest_release}$"
}

commit_last_release()
{
    commit="$1"

    "${topdir}"/resources/git/git \
        -C "$(guix_checkout)" \
        tag \
        --sort=taggerdate \
        --merged "${commit}" | \
        grep '^v[0-9]' | \
        sed 's#^v##' | \
        tail -n1

}

guix_next_version()
{
    version="$1"

    case "${version}" in
        "0.0")
            echo "0.1" ; return ${true} ;;
        "0.1")
            echo "0.2" ; return ${true} ;;
        "0.2")
            echo "0.3" ; return ${true} ;;
        "0.3")
            echo "0.4" ; return ${true} ;;
        "0.4")
            echo "0.5" ; return ${true} ;;
        "0.5")
            echo "0.6" ; return ${true} ;;
        "0.6")
            echo "0.7" ; return ${true} ;;
        "0.7")
            echo "0.8" ; return ${true} ;;
        "0.8")
            echo "0.8.1" ; return ${true} ;;
        "0.8.1")
            echo "0.8.2" ; return ${true} ;;
        "0.8.2")
            echo "0.8.3" ; return ${true} ;;
        "0.8.3")
            echo "0.9.0" ; return ${true} ;;
        "0.9.0")
            echo "0.10.0" ; return ${true} ;;
        "0.10.0")
            echo "0.11.0" ; return ${true} ;;
        "0.11.0")
            echo "0.12.0" ; return ${true} ;;
        "0.12.0")
            echo "0.13.0" ; return ${true} ;;
        "0.13.0")
            echo "0.14.0" ; return ${true} ;;
        "0.14.0")
            echo "0.15.0" ; return ${true} ;;
        "0.15.0")
            echo "0.16.0" ; return ${true} ;;
        "0.16.0")
            echo "1.0.0" ; return ${true} ;;
        "1.0.0")
            echo "1.0.1" ; return ${true} ;;
        "1.0.1")
            echo "1.1.0" ; return ${true} ;;
        "1.1.0")
            echo "1.2.0" ; return ${true} ;;
        "1.2.0")
            echo "1.3.0" ; return ${true} ;;
        "1.3.0")
            echo "1.4.0" ; return ${true} ;;
    esac

    if is_known_version "${version}" && is_rc_version "${version}"; then
        # According to https://www.shellcheck.net/wiki/SC2001 bash
        # substitution doesn't support regexes.
        # shellcheck disable=SC2001
        echo "${version}" | sed 's/rc[0-9]\+//'
        return ${true}
    else
        return ${false}
    fi
}

next_guix_release()
{
    version="$1"

    major="$(echo "${version}" | awk -F . '{print $1}')"

    if is_latest_release "${version}" ; then
        return ${true}
    fi

    # We use a released version already
    if [ -n "${major}" ] ; then
        guix_next_version "${version}"
        return $?
    fi

    # Git revision
    if commit_contains_last_release "${version}" ; then
        return ${true}
    else
        base_version=$(commit_last_release "${version}")
        guix_next_version "${base_version}"
        return $?
    fi
}

# Find Guix checkout location
guix_checkout()
{
    for repo in "${HOME}"/.cache/guix/checkouts/*/ ; do
        url=$("${topdir}"/resources/git/git -C "$repo" remote get-url origin)
        if [ "${url}" = "https://git.savannah.gnu.org/git/guix.git" ] ; then
            echo "$repo"
        fi
    done
}

is_latest_release()
{
    revision="$1"

    if [ "${revision}" = "${guix_latest_release}" ] ; then
        return ${true}
    elif echo "${revision}" | grep -q '\.' ; then
        return ${false}
    elif "${topdir}"/resources/git/git -C "$(guix_checkout)" tag --merged "${revision}" | \
            grep "^v${guix_latest_release}$" > /dev/null ; then
        return ${true}
    else
        return ${false}
    fi
}

update_guix_to_latest_release()
{
    current_version="$(guix_version)"

    major="$(echo "${current_version}" | awk -F . '{print $1}')"

    if is_latest_release "${current_version}" ; then
        return ${true}
    fi

    # We use a released version already
    if [ -n "${major}" ] ; then
        commit="$(guix_version_commit "v$(guix_next_version "${current_version}")")"
        guix pull --commit="${commit}"
        source_guix_profile
        update_guix_to_latest_release
    fi
}

source_guix_profile
