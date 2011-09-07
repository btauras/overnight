# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 multilib

DESCRIPTION="ASIO driver for Wine"
HOMEPAGE="http://sourceforge.net/projects/wineasio"
EGIT_REPO_URI="git://wineasio.git.sourceforge.net/gitroot/${PN}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/asio-sdk"
RDEPEND="${DEPEND}"

DEPEND="media-libs/asio-sdk"
RDEPEND="app-emulation/wine
	amd64? ( media-sound/jack-audio-connection-kit[32bit] )
	!amd64? ( media-sound/jack-audio-connection-kit )"

S="${WORKDIR}/${PN}"

src_prepare() {
	cp /opt/asiosdk2.2/common/asio.h .
}

src_install() {
	if use amd64 ; then
		exeinto /usr/lib32/wine
		doexe *.so
	elif use x86 ; then
		exeinto /usr/lib/wine
		doexe *.so
	fi

	dodoc README
}

pkg_postinst() {
	elog "You need to register ${PN}.dll by running:"
	elog "$ regsvr32 wineasio.dll"
	elog "...as your regular Wine user. Then run:"
	elog "$ winecfg"
	elog "...and go to the Audio tab. Make sure that"
	elog "ONLY the 'ALSA' box is checked."
}
