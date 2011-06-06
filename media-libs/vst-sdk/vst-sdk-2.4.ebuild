# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit eutils

DESCRIPTION="Steinberg VST PlugIn SDK"
HOMEPAGE="http://www.steinberg.net/en/company/developer.html"
SRC_URI="${DISTDIR}/vst_sdk2_4_rev2.zip"
LICENSE="STEINBERG MEDIA TECHNOLOGIES GMBH"
IUSE=""
RESTRICT="nostrip fetch"

SLOT="2.4"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/vstsdk2.4"

pkg_nofetch() {
	elog "Please go to ${HOMEPAGE} and download '${A}'"
	elog "after agreeing to the license terms, and"
	elog "place it in ${DISTDIR}"
}

src_install() {
	dodir /usr/include/vst24
	cp ${S}/public.sdk/source/vst2.x/* ${D}/usr/include/vst24 || die
	dodir /usr/include/pluginterfaces/vst2.x
	cp ${S}/pluginterfaces/vst2.x/*	${D}/usr/include/pluginterfaces/vst2.x || die
	sed -i -e "s/#define VSTCALLBACK __cdecl/#define VSTCALLBACK/g" \
		${D}/usr/include/pluginterfaces/vst2.x/aeffect.h || die
	dodoc ${S}/doc/VST\ Licensing\ Agreement.rtf
}

pkg_postinst() {
	elog "Please review the license in"
	elog "/usr/share/doc/${P}"
}
