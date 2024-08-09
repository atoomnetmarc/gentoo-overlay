# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

MY_PN=cura

case "${PV}" in
	*_beta*) MY_PV="${PV/_beta/-beta.}" ;;
	*_rc*) MY_PV="${PV/_rc/-RC}" ;;
	*) MY_PV="${PV}"
esac

APPIMAGE="UltiMaker-Cura-${PV%%_*}-linux-X64.AppImage"

DESCRIPTION="3D printer / slicing GUI built on top of the Uranium framework"
HOMEPAGE="https://github.com/Ultimaker/Cura"

SRC_URI="${HOMEPAGE}/releases/download/${MY_PV}/${APPIMAGE} -> ${APPIMAGE}
	https://upload.wikimedia.org/wikipedia/commons/9/9b/Logo_for_Cura_Software.png -> ${P}-icon.png"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
RESTRICT="bindist mirror strip"

RDEPEND="sys-fs/fuse:0"

QA_PREBUILT="*"

S="${WORKDIR}"

src_install() {
	exeinto "/opt/${MY_PN}"
	doexe "${DISTDIR}/${APPIMAGE}"
	dosym "/opt/${MY_PN}/${APPIMAGE}" "/usr/bin/${MY_PN}" || die "dosym failed"
	newicon -s 128 "${DISTDIR}/${P}-icon.png" "${MY_PN}-icon.png" || die "doicon failed"
	domenu "${FILESDIR}/${MY_PN}.desktop"
}
