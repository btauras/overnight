# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

WX_GTK_VER="2.8"
EAPI=2
inherit wxwidgets

DESCRIPTION="Audio loop slicer"
HOMEPAGE="http://smasher.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/libmad
	media-libs/libsndfile
	media-sound/csound[double-precision]
	x11-libs/wxGTK:2.8[gstreamer]"


src_install() {
	emake DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS README
}
