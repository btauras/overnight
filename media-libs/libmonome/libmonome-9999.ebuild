# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="git://github.com/nightmorph/libmonome.git"

inherit waf-utils git-2 multilib

DESCRIPTION="A library for easy interaction with monome devices"
HOMEPAGE="http://github.com/monome/libmonome"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="python" #until upstream fixes the broken python bindings
IUSE=""

DEPEND="media-libs/liblo
	sys-fs/udev"
#	python? ( || ( dev-lang/python:2.7 dev-lang/python:2.6 ) )"

RDEPEND="${DEPEND}
	dev-util/pkgconfig"
