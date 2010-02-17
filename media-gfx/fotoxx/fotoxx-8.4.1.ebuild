# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Program for improving image files made with a digital camera."
HOMEPAGE="http://kornelix.squarespace.com/fotoxx"
SRC_URI="http://kornelix.squarespace.com/storage/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# fotoxx uses freeimage only for tiff output;
# jpeg saving uses the pixbuf library (part of gtk+)
DEPEND=">=x11-libs/gtk+-2.8
	media-libs/freeimage"
RDEPEND="${DEPEND}
	media-gfx/ufraw
	media-libs/exiftool
	x11-misc/xdg-utils"

src_compile() {
	emake PREFIX=/usr || die "build failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die "emake install failed"
	make_desktop_entry ${PN} "Fotoxx" /usr/share/${PN}/icons/${PN}.png "Application;Graphics;2DGraphics;"
}

pkg_postinst() {
	elog ""
	elog "For easy photo printing, try media-gfx/printoxx"
	elog ""
}
