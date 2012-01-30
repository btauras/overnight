# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib toolchain-funcs

DESCRIPTION="LADSPA effect plugins"
HOMEPAGE="http://code.google.com/p/foo-plugins"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/ladspa-sdk"

src_compile() {
	tc-export CC
	emake
}

src_install() {
	insinto /usr/$(get_libdir)/ladspa
	insopts -m0755
	doins *.so

	dodoc README
}
