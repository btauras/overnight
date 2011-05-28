# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="git://github.com/artfwo/griddle.git"

inherit git-2

DESCRIPTION="Splitter/spanner router app for grid devices"
HOMEPAGE="http://github.com/artfwo/griddle"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+meme"

RDEPEND="dev-python/pybonjour
	dev-libs/pyOSC
	meme? ( dev-python/pygtk )"
DEPEND=""

src_install() {
	dobin griddle.py
	use meme && dobin meme-osc.py
}
