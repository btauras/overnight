# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

MY_P="Blokkal-${PV}"

DESCRIPTION="An extendable blogging client for KDE4"
HOMEPAGE="http://blokkal.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="4"
IUSE=""

RDEPEND=">=kde-base/kdepimlibs-${KDE_MINIMAL}
	>=media-sound/phonon-${KDE_MINIMAL}"
DEPEND="${RDEPEND}
	>=kde-base/kwallet-${KDE_MINIMAL}"

S="${WORKDIR}/${MY_P}"
