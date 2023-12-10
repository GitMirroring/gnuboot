# 
# Makefile for compatibility purposes
# You can use this, but it's recommended to run build system commands directly
#
# See docs/maintain/ and docs/git/ for information about the build system
#
# Copyright (C) 2020, 2021 Leah Rowe <info@minifree.org>
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
#

.PHONY: all check download modules ich9m-descriptors payloads roms release \
	clean crossgcc-clean install-dependencies-ubuntu \
	install-dependencies-pureos-10 install-dependencies-arch \
	install-dependencies-void

LOG = make-$(shell date '+%s').log

all: roms

download:
	echo 'Makefile: running $@ target' >> $(LOG)
	./download all 2>&1 | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

modules:
	echo 'Makefile: running $@ target' >> $(LOG)
	./build module all 2>&1 | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

ich9m-descriptors:
	echo 'Makefile: running $@ target' >> $(LOG)
	./build build descriptors | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

payloads:
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./build payload all | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

roms:
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./build boot roms all | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

release:
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./build release src | tee -a $(LOG)
	set -o pipefail ; ./build release roms | tee -a $(LOG)
	set -o pipefail ; ./build release website | tee -a $(LOG)
	set -o pipefail ; ./build release gnuboot-source | tee -a $(LOG)
	set -o pipefail ; ./build test release | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

clean:
	./build clean cbutils
	./build clean flashrom
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

install-dependencies-ubuntu:
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./build dependencies trisquel-10 | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

install-dependencies-pureos-10:
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./build dependencies pureos-10 | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

install-dependencies-arch:
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./build dependencies arch | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

install-dependencies-void:
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./build dependencies void | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."

check:
	echo 'Makefile: running $@ target' >> $(LOG)
	set -o pipefail ; ./tests/lint | tee -a $(LOG)
	set -o pipefail ; ./tests/distclean | tee -a $(LOG)
	set -o pipefail ; ./tests/targets  2>&1 | tee -a $(LOG)
	@echo "[ OK ] Makefile: $@ target. See $(LOG) for the log."
