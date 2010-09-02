# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="A library for document classification and fingerprinting"
HOMEPAGE="http://software.wise-guys.nl/libtextcat/"
SRC_URI="http://software.wise-guys.nl/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	econf --prefix=/usr
	emake
	}
		
src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README TODO
	}
