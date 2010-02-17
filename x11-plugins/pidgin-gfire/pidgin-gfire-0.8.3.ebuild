# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-libnotify/pidgin-libnotify-0.14.ebuild,v 1.5 2009/09/06 14:42:07 maekke Exp $

EAPI="2"

inherit eutils

DESCRIPTION="An Xfire plugin for Pidgin"
HOMEPAGE="http://gfire.sourceforge.net/"
SRC_URI="mirror://sourceforge/gfire/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE="debug"

RDEPEND="net-im/pidgin[gtk]
	>=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

#src_prepare() {
#	epatch "${FILESDIR}"/pidgin-libnotify-showbutton.patch
#}

src_configure() {
	econf ${myconf} || die "configure failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README VERSION
}
