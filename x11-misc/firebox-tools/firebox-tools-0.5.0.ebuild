# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

DESCRIPTION="Tools for the Firebox window manager"
HOMEPAGE="http://firebox.intuxication.org"
SRC_URI="http://download.gna.org/firebox/tarballs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="${DEPEND}
	x11-wm/firebox"
DEPEND="dev-libs/libxml2
	dev-util/pkgconfig
	sys-devel/gettext
	x11-libs/gtk+:2"

src_compile() {
	econf \
		$(use_enable debug) \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
}
