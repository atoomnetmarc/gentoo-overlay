# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="A free and open TL866XX programmer"
HOMEPAGE="https://gitlab.com/DavidGriffith/minipro"
SRC_URI="https://gitlab.com/DavidGriffith/minipro/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/libusb:1"
DEPEND="${RDEPEND}"

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
}