# 
# Makefile for compatibility purposes
# You can use this, but it's recommended to run build system commands directly
#
# See docs/maintain/ and docs/git/ for information about the build system
#
# Copyright (C) 2020, 2021 Leah Rowe <info@minifree.org>
# Copyright (C) 2021 shmalebx9 <thonkpeasant@protonmail.com>
# Copyright (C) 2022-2024 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
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
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# For making pipefail work.
SHELL := bash

.PHONY: all check download modules ich9m-descriptors payloads roms release \
	clean crossgcc-clean  \
	install-dependencies-pureos-trisquel install-dependencies-arch \
	install-dependencies-void

LOG = make-$(shell date '+%s').log

all: roms

$(LOG):
	@echo -n "git revision: "  >> $@
	resources/git/git describe >> $@
	@echo -n "----------------------------------------"  >> $@
	@echo    "----------------------------------------"  >> $@

download: $(LOG)
	echo 'Makefile: running $@ target' >> $(LOG)
	./download all 2>&1 | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

modules: $(LOG)
	echo 'Makefile: running $@ target' >> $(LOG)
	./build module all 2>&1 | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

ich9m-descriptors: $(LOG)
	echo 'Makefile: running $@ target' >> $(LOG)
	./build build descriptors | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

payloads: $(LOG)
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./build payload all | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

roms: $(LOG)
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./build boot roms all | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

release: $(LOG)
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./build release src | tee -a $(LOG)
	set -o pipefail ; ./build release roms | tee -a $(LOG)
	set -o pipefail ; ./build release website | tee -a $(LOG)
	set -o pipefail ; ./build release gnuboot-source | tee -a $(LOG)
	set -o pipefail ; ./build test roms | tee -a $(LOG)
	set -o pipefail ; ./build test release | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

clean:
	./build clean cbutils
	./build clean i945-thinkpads-install-utilities
	./build clean ich9utils
	./build clean payloads
	./build clean seabios
	./build clean grub
	./build clean memtest86plus
	./build clean rom_images

crossgcc-clean:
	./build clean crossgcc

distclean:
	./build distclean all

install-dependencies-pureos-trisquel: $(LOG)
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./build dependencies pureos-trisquel | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

install-dependencies-arch: $(LOG)
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./build dependencies arch | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

install-dependencies-void: $(LOG)
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./build dependencies void | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

check: $(LOG)
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./tests/lint | tee -a $(LOG)
	set -o pipefail ; ./tests/distclean | tee -a $(LOG)
	set -o pipefail ; ./tests/targets  2>&1 | tee -a $(LOG)
	set -o pipefail ; ./tests/checkpatch 2>&1 | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

include resources/packages/i945-thinkpads-install-utilities/Makefile.am

help:
	@printf "Available commands:\n"
	@printf "\t# Install required dependencies on PureOS 10 (byzantium).\n"
	@printf "\tsudo make install-dependencies-pureos-trisquel\n\n" \
	@printf "\tmake release                               # %s\n" \
		"Build a GNU Boot release."
	@printf "\tmake clean                                 # %s\n" \
		"Remove all the files being built in GNU Boot."
	@printf "\tmake crossgcc-clean                        # %s\n" \
		"Remove the builds of the crossgcc toolchain."
	@printf "\tmake i945-thinkpads-install-utilities-help # %s\n" \
		"Print i945-thinkpads-install-utilities targets help."
