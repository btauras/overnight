# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="An Xfire plugin for Pidgin"
HOMEPAGE="http://gfire.sourceforge.net/"
SRC_URI="mirror://sourceforge/gfire/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE="debug +libnotify"

RDEPEND="libnotify? ( x11-libs/libnotify )
	net-im/pidgin[gtk]
	x11-libs/gtk+:2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
	$(use_enable debug) \
	$(use_enable libnotify) \
	|| die "configure failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README VERSION
}
