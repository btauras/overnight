# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit cmake-utils versionator

DESCRIPTION="A basic application for burning CDs and DVDs"
HOMEPAGE="http://simpleburn.tuxfamily.org"
SRC_URI="http://download.tuxfamily.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/gtk+:2"
RDEPEND="${DEPEND}
	app-cdr/cdrtools"
