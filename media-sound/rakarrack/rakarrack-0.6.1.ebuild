# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="Guitar effects rack"
HOMEPAGE="http://rakarrack.sourceforge.net/"
SRC_URI="mirror://sourceforge/rakarrack/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/fltk:1
	x11-libs/libXpm
	media-libs/alsa-lib
	media-sound/alsa-utils
	media-sound/jack-audio-connection-kit"
RDEPEND="${DEPEND}"

src_prepare() {
	# force configure check for -lfltk
	epatch "${FILESDIR}/fltk-configure.patch"
}

src_install() {
	emake DESTDIR="${D}" install
	insinto /usr/share/doc/"${PN}"
	doins TODO
}
