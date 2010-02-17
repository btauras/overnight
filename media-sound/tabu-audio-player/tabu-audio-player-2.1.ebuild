# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools

DESCRIPTION="A simple gstreamer audio player"
HOMEPAGE="http://www.kalmbach.com.ar/?page_id=7"
SRC_URI="http://www.kalmbach.com.ar/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="media-plugins/gst-plugins-meta
	media-libs/taglib
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's:-O2::g' Makefile.am
	eautoreconf
}

src_configure() {
	# configure is broken; --disable-debug still enables it
	local my_conf
	use debug && my_conf="--enable-debug"
	econf ${my_conf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README
}
