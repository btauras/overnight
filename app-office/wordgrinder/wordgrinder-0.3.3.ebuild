# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A console-based word processor"
HOMEPAGE="http://wordgrinder.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/luafilesystem
	sys-libs/ncurses"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-pmfile.patch"
}

#src_compile() {
#	cd "${S}"
#	./pm wordgrinder_release_exe wordgrinder_man || die "pm compile failed"
#}

#src_install() {
#	dobin wordgrinder
#	doman wordgrinder.1 || die "doman failed"
#	dodoc README.wg || die "dodoc failed"
#}

src_install() {
	cd "${S}"
	./pm install || die "pm install failed"
}

pkg_postinst() {
	elog "To run WordGrinder in X, you'll need decent Unicode fonts"
	elog "and a Unicode terminal. Try xterm, terminal, rxvt-unicode,"
	elog "evilvte, konsole, or gnome-terminal."
}
