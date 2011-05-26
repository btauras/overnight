# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2 3"
#SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils

DESCRIPTION="Python wrapper for the liblo OSC library"
HOMEPAGE="http://das.nasophon.de/pyliblo"
SRC_URI="http://das.nasophon.de/download/${P}.tar.gz \
	https://launchpad.net/~artfwo/+archive/ppa/+files/${PN}_${PV}-2ubuntu1%7Enatty1.debian.tar.gz"
	# patch required until upstream includes this code

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/liblo-0.26"
DEPEND="${RDEPEND}
	dev-python/cython"

src_prepare() {
	EPATCH_SOURCE="${WORKDIR}/debian/patches"
	epatch
}
