# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils multilib toolchain-funcs

DESCRIPTION="LADSPA effect plugins from Invada Studio"
HOMEPAGE="http://www.invadarecords.com/Downloads.php?ID=00000263"
SRC_URI="http://www.invadarecords.com/downloads/${PN}_${PV}-1.tar.gz"

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

	insinto /usr/share/ladspa/rdf
	doins inv_plugins.rdf

	dodoc CREDITS README
}
