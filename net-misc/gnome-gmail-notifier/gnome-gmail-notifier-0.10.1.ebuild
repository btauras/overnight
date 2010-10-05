# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit gnome2

DESCRIPTION="GNOME Gmail Notifier"
HOMEPAGE="http://notifier.geekysuavo.org/"
SRC_URI="http://files.geekysuavo.org/notifier/${P}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	gnome-base/gconf
	net-libs/libsoup:2.4
	x11-libs/libnotify
	dev-libs/libxml2
	gnome-base/gnome-keyring
	media-plugins/gst-plugins-meta"

RDEPEND="${DEPEND}"

# can also optionally use networkmanager. i don't, so
# i didn't even bother to add the USE flags for it


src_install() {
	emake install DESTDIR=${D} || die "Failed at emake install"
	dodoc AUTHORS ChangeLog README NEWS
}

