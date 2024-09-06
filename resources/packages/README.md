Common tasks
------------
boot:      Produce some binary that boots and install it in bin/.
clean:     Remove all built files.
distclean: Remove all files including build configuration files.
download:  Download files for offline building. Sometimes also builds or
           download already-built packages when Guix is being used.
module:    Build some project in its source tree.
payload:   Produce a payload and install it in payload/.
release:   Install files in release/ for making a GNU Boot release.
test:      Run automatic tests of the package.

Task specific to descriptors
----------------------------
build: build the Intel flash descriptors and put them in build/descriptors.

Task specific to dependencies
-----------------------------
install: install dependencies. See the
website/pages/docs/build/index.md documentation for more details.

Tasks specific to u-boot
------------------------
deblob-download: See commit 4744953f7345dd8ccf452c3acbe1597b6a2fef52
                 ("u-boot-libre: move to different tasks.") for more details.
deblob-release:  See commit 4744953f7345dd8ccf452c3acbe1597b6a2fef52
                 ("u-boot-libre: move to different tasks.") for more details.
