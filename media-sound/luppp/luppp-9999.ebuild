# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit git-2 fdo-mime toolchain-funcs

DESCRIPTION="Live realtime music creation and performance tool"
HOMEPAGE="https://github.com/harryhaaren/Luppp"
EGIT_REPO_URI="git://github.com/harryhaaren/Luppp"
EGIT_BRANCH="devel"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-cpp/glibmm:2
	dev-cpp/gtkmm:2.4
	dev-libs/libconfig
	dev-util/pkgconfig
	media-libs/ladspa-sdk
	media-libs/liblo
	media-libs/libsndfile
	>=media-libs/lilv-0.14.2
	media-libs/suil
	media-sound/fluidsynth
	>=media-sound/jack-audio-connection-kit-0.118"

src_configure() {
	tc-export CC CXX

	./waf configure \
		--prefix=/usr \
		|| die "config failed"
}

src_compile() {
	./waf || die "build failed"
}

src_install() {
	./waf --destdir="${D}" install

	newicon src/lupppIcon.png ${PN}.png
	make_desktop_entry luppp Luppp Luppp AudioVideo;
	dodoc README
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_mime_desktop_database_update
}
