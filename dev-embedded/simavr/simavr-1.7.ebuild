# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Atmel AVR simulator"
HOMEPAGE="https://github.com/buserror/simavr"

SRC_URI="https://github.com/buserror/simavr/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

PATCHES="
	${FILESDIR}/${PN}-install.patch
"

src_compile() {
	emake build-simavr
}

src_install() {
	local OBJ="obj-$(gcc -dumpmachine)"

	emake DESTDIR="${D}/usr" install-simavr
	newbin simavr/${OBJ}/run_avr.elf simavr
	dolib.so simavr/${OBJ}/libsimavr.so.1
	dodoc doc/manual/manual.pdf
}
