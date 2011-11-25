# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit fdo-mime qt4-r2 subversion

DESCRIPTION="A simple stereo recorder for JACK"
HOMEPAGE="http://sourceforge.net/projects/qjackrcd/"
ESVN_REPO_URI="svn://svn.code.sf.net/p/qjackrcd/code/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/qt-gui:4"
RDEPEND="media-libs/libsndfile
	media-sound/jack-audio-connection-kit"

src_install() {
	dobin qjackrcd
	newicon record-green.png ${PN}.png
	make_desktop_entry qjackrcd QJackRcd qjackrcd AudioVideo;
}
