#!/usr/bin/env python3
#
# Copyright (C) 2024 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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

import configparser
import os
import subprocess
import sys

def get_environment(env, string):
    left = None
    right = None

    sep = string.rfind('=')
    start = string[:sep].rfind(' ')

    left = string[start + 1:sep]

    if sep + 1 == len(string):
        right = None
    else:
        if left[0] == '"':
            left = string[start + 2:sep]
            right = string[sep + 1:string[start + 2:sep].rfind('"') ]
        elif left[0] == "'":
            left = string[start + 2:sep]
            right = string[sep + 1:string[start + 2:sep].rfind("'") ]
        else:
            right = string[sep + 1:]

            if right[0] == "'" and right[-1] == "'":
                right = right[1:-1]
            elif right[0] == '"' and right[-1] == '"':
                right = right[1:-1]

    env[left] = right
    if start > 0:
        get_environment(env, string[:start])

    return env

def test_get_environment():
    env1 = get_environment({}, """ONE='one' "TWO='two two' too" THREE=""")
    env2 = {'ONE': 'one',
            'TWO': "'two two' too",
            'THREE': None}

    k1 = sorted(env1.keys())
    k2 = sorted(env2.keys())
    assert(k1 == k2)

    for k in env1.keys():
        assert(env1[k] == env2[k])

test_get_environment()

def run_systemd_service_unit(binary_name, service_file_path):
    print("Starting {}.".format(binary_name))
    result = subprocess.run(["pidof", "-c", binary_name])
    if result.returncode == 0:
        return

    config = configparser.ConfigParser(strict=False)

    config.read(service_file_path)

    # man 5 systemd.service has "Unless Type= is oneshot, exactly one
    # command must be given." about ExecStart=
    # if config.get('Service', 'Type'):
    #     print("Invalid /lib/systemd/system/guix-daemon.service file.")
    #     sys.exit(os.EX_OSFILE)
    command = config.get('Service', 'ExecStart')

    if config.get('Service', 'Environment', fallback=False):
        subprocess.run([command + " & "],
                       shell=True,
                       capture_output=True,
                       env=get_environment({}, config.get('Service', 'Environment')))

def mount_store_ro():
    mounts = open('/proc/mounts', 'r').readlines()
    for mount in mounts:
        # Trust that the kernel will always use spaces not to break userspace.
        fields = mount.split(" ")

        target = fields[1]
        options = fields[3]

        if target == '/gnu/store':
            if 'ro' not in options:
                subprocess.run(["mount", "-o", "bind,ro", "/gnu/store", "/gnu/store"])

if 'ID=guix\n' in open('/etc/os-release', 'r').readlines():
    print("This script is not meant to run on a guix system.")
    print("It's meant for running Guix on foreign distro (in a chroot).")
    sys.exit(os.EX_OSFILE)

if os.geteuid() != 0:
    print("This script can only run as root.")
    sys.exit(os.EX_NOPERM)

mount_store_ro()
run_systemd_service_unit('nscd', '/lib/systemd/system/nscd.service')
run_systemd_service_unit('guix-daemon', '/lib/systemd/system/guix-daemon.service')
