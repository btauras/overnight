# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="GUI for FST and dssi-vst, for running Windows VSTs"
HOMEPAGE="http://festige.sf.net"
SRC_URI="mirror://sourceforge/project/${PN}/${PV}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dssi-vst"

DEPEND="app-emulation/wine
	dev-lang/python:2.7
	dev-python/PyQt4
	x11-libs/gtk+:2
	dssi-vst? ( media-plugins/dssi-vst )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

# not parallel build-safe; -j1 forced
src_install() {
	emake -j1 PREFIX=/usr DESTDIR="${D}" install
}

pkg_postinst() {
	elog "Be sure to read the tutorial:"
	elog "http://kxstudio.sf.net/festige"
}

