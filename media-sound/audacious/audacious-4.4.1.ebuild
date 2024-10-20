# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${P/_/-}"

inherit xdg

DESCRIPTION="Lightweight and versatile audio player"
HOMEPAGE="https://audacious-media-player.org/"
SRC_URI="https://distfiles.audacious-media-player.org/${MY_P}.tar.bz2"
SRC_URI+=" mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

KEYWORDS="amd64 ~riscv x86"
LICENSE="BSD-2"
SLOT="0"
IUSE="nls"

BDEPEND="
	virtual/pkgconfig
	nls? ( dev-util/intltool )
"
DEPEND="
	dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	virtual/freedesktop-icon-theme
"
RDEPEND="${DEPEND}"
PDEPEND="~media-plugins/audacious-plugins-${PV}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	if ! use nls; then
		sed -e "/SUBDIRS/s/ po//" -i Makefile || die "failed to sed" # bug #512698
	fi
}

src_configure() {
	# D-Bus is a mandatory dependency, remote control,
	# session management and some plugins depend on this.
	# Building without D-Bus is *unsupported* and a USE-flag
	# will not be added due to the bug reports that will result.
	# Bugs #197894, #199069, #207330, #208606
	local myeconfargs=(
		--disable-valgrind
		--disable-gtk
		--enable-dbus
		--enable-qt5
		$(use_enable nls)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default

	# Gentoo_ice skin installation; bug #109772
	insinto /usr/share/audacious/Skins/gentoo_ice
	doins -r "${WORKDIR}"/gentoo_ice/.
	docinto gentoo_ice
	dodoc "${WORKDIR}"/README
}
