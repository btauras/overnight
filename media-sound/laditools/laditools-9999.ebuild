# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit distutils git-2

DESCRIPTION="Integration and configuration tools for LADISH"
HOMEPAGE="http://launchpad.net/laditools"
EGIT_REPO_URI="git://github.com/alessio/laditools"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/pygtk
	dev-python/pyyaml
	media-sound/jack-audio-connection-kit[dbus]
	x11-libs/vte[python]"
DEPEND="dev-python/python-distutils-extra"

DOCS="AUTHORS README"
