# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit eutils

MY_PV="2010-02-14"

DESCRIPTION="MDA VST plugins"
HOMEPAGE="http://sourceforge.net/projects/mda-vst"
SRC_URI="mirror://sourceforge/mda-vst/files/${PN}-src-${MY_PV}.zip"

LICENSE="MIT GPL-2"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""

RDEPEND=">=media-libs/vst-sdk-2.4"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
	cd "${S}/${PN}.linux/"
	emake SDK=/usr/include/vst24/ all
}

src_install() {
	cd "${S}/${PN}.linux/"
	dodir /usr/$(get_libdir)/vst
	cp -R *.so "${D}/usr/$(get_libdir)/vst"
}
