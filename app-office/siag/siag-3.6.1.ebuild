# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A free Office package for Linux"
SRC_URI="ftp://siag.nu/pub/siag/${P}.tar.gz"
HOMEPAGE="http://siag.nu/"
IUSE="ccmath images python"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64"


# TODO: optional ruby support, check addl. flags in acinclude etc.
DEPEND="dev-libs/gmp
	x11-misc/Mowitz
	dev-lang/tcl
	x11-libs/libXaw
	x11-libs/libXpm"

RDEPEND="${DEPEND}
	ccmath? ( dev-libs/ccmath )
	python? ( dev-lang/python )
	images? ( media-libs/netpbm )"

src_unpack() {
	unpack ${A}
	cd ${S}

	for file in `find . -iname "Makefile.*"`; do
		grep -v "kdeinst" ${file} >${file}.hacked && \
		mv ${file}.hacked ${file} || die "Hacking of ${file} failed"
	done
}

src_compile() {
	./configure \
		--prefix=/usr \
		--with-xawm=Xaw \
		--mandir=/usr/share/man \
		#--host="${CHOST}" \
		#--with-xawm=neXtaw \
		#--with-ccmath \
		#--with-python \
		#|| die "Configure failed"
}

src_install() {
	emake DESTDIR=${D} install || die "Install failed"
	dodoc AUTHORS ChangeLog FILES NEWS NLS README
}
