# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_PN="${PN/-/}"
MY_P="${MY_PN}${PV}"

DESCRIPTION="Steinberg ASIO SDK"
HOMEPAGE="http://www.steinberg.net/en/company/developer.html"
SRC_URI="${DISTDIR}/${MY_P}.zip"

RESTRICT="nostrip fetch"

LICENSE="STEINBERG MEDIA TECHNOLOGIES GMBH"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/unzip"
S="${WORKDIR}/ASIOSDK2"

pkg_nofetch() {
	elog "Please go to ${HOMEPAGE} and download ${A}"
	elog "after agreeing to the license terms, and"
	elog "place it in ${DISTDIR}"
}

src_install() {
	cd "${S}"
	dodir /opt/${MY_P}
	mv ./* ${D}/opt/${MY_P}
}

pkg_postinst() {
	elog "${P} has been installed to /opt/${MY_P}"
	elog "Please review the license in /opt/${MY_P}"
}
