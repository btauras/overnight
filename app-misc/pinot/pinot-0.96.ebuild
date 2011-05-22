# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit linux-info

DESCRIPTION="Pinot is a D-Bus service that crawls, indexes your documents and
monitors them for changes"
HOMEPAGE="http://pinot.berlios.de/index.html"
SRC_URI="mirror://berlios/pinot/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="deskbar djvu dvi libarchive odf pdf ppt rtf word"

CONFIG_CHECK="~INOTIFY"
ERROR_INOTIFY="Recompile your kernel with inotify support - CONFIG_INOTIFY"

DEPEND="dev-libs/dbus-glib
	dev-cpp/gtkmm:2.4
	dev-cpp/libxmlpp:2.6
	dev-db/sqlite:3
	dev-libs/boost
	dev-libs/gmime:2.4
	dev-libs/libtextcat
	dev-libs/xapian
	dev-util/desktop-file-utils
	media-libs/libexif
	media-libs/taglib
	net-misc/curl	
	x11-misc/shared-mime-info
	libarchive? ( app-arch/libarchive )"
RDEPEND="${DEPEND}
	deskbar? ( gnome-extra/deskbar-applet )
	djvu? ( app-text/djvu )
	dvi? ( dev-tex/catdvi )
	odf? ( app-arch/unzip )
	pdf? ( app-text/poppler )
	ppt? ( app-text/catdoc )
	rtf? ( app-text/unrtf )
	word? ( app-text/antiword )"

src_configure() {
	econf $(use_enable libarchive)
}
