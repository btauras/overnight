# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

S=${WORKDIR}/Mowitz-${PV}
SRC_URI="http://siag.nu/pub/mowitz/Mowitz-${PV}.tar.gz"
HOMEPAGE="http://siag.nu/mowitz/"
DESCRIPTION="Mowitz - more widgets library"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/neXtaw"

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
}
