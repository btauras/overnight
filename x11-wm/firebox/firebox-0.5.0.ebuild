# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

DESCRIPTION="Firebox is a lightweight window manager"
HOMEPAGE="http://firebox.intuxication.org"
SRC_URI="http://download.gna.org/firebox/tarballs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +jpeg +png +xcomposite +xft +xrender +xshape"

RDEPEND="${DEPEND}"

# xextproto is for the xshape extension, which does have a configure check;
# should probably just be mandatory anyway. Same for the xrender extension.
# png, jpeg, and xft support should also probably be mandatory, but
# they do have configure switches. Thus the USE flags.
DEPEND="dev-libs/libxml2
	dev-util/pkgconfig
	sys-devel/gettext
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )
	xcomposite? ( x11-libs/libXcomposite )
	xft? ( x11-libs/libXft )
	xrender? ( x11-libs/libXrender )
	xshape? ( x11-proto/xextproto )"

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable debug mtrace) \
		$(use_enable jpeg ) \
		$(use_enable png ) \
		$(use_enable xcomposite ) \
		$(use_enable xft ) \
		$(use_enable xrender ) \
		$(use_enable xshape ) \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
}

