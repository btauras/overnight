# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit git-2

DESCRIPTION="Session management system for JACK applications"
HOMEPAGE="http://ladish.org/"
EGIT_REPO_URI="git://repo.or.cz/ladish"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug lash python"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
RDEPEND="dev-lang/python
	dev-libs/dbus-glib
	dev-libs/glib:2
	gnome-base/libglade
	media-sound/jack-audio-connection-kit[dbus]
	>=x11-libs/flowcanvas-0.6.4
	x11-libs/gtk+:2
	lash? ( media-sound/lash )
	python? ( media-sound/lash[python] )"

src_configure() {
	./waf configure \
		--prefix=/usr \
		$(use debug && echo "--debug") \
		$(use lash && echo "--enable-liblash") \
		$(use python && echo "--enable-liblash --enable-pylash") \
		|| die "waf configure failed"
}

src_compile() {
	./waf || die "waf compile failed"
}

src_install() {
	./waf install --destdir="${D}"
	dodoc AUTHORS NEWS README
}
