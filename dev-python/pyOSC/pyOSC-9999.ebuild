# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

EGIT_REPO_URI="git://gitorious.org/pyosc/devel.git"

PYTHON_DEPEND="2"

inherit git-2 distutils

DESCRIPTION="Python implementation of OpenSoundControl (OSC)"
HOMEPAGE="http://gitorious.org/pyosc"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/setuptools"
DEPEND=""
