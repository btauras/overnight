# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

DESCRIPTION="A lightweight music manager"
HOMEPAGE="https://sites.google.com/site/consonancemanager/"
SRC_URI="https://sites.google.com/site/consonancemanager/releases-1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/dbus-glib
	dev-db/sqlite:3
	media-libs/flac
	media-libs/libao
	media-libs/libmad
	media-libs/libsndfile
	media-libs/libvorbis
	>=dev-libs/libcdio-0.80
	>=media-libs/libcddb-1.3.0
	media-libs/libmodplug
	media-libs/taglib
	x11-libs/gtk+:2
	x11-libs/libnotify"
RDEPEND="${DEPEND}"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
}
