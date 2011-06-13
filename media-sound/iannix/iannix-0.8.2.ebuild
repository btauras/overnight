# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils qt4-r2

DESCRIPTION="Graphical sequencer for digital art"
HOMEPAGE="http://www.iannix.org"
SRC_URI="http://iannix.org/en/download/${PN}_sources__0_8_2.zip"

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples +jack"

S="${WORKDIR}/IanniX"

RDEPEND="${DEPEND}"
DEPEND="media-libs/alsa-lib
	x11-libs/qt-core
	x11-libs/qt-gui
	x11-libs/qt-opengl
	jack? ( media-sound/jack-audio-connection-kit )"

#src_configure() {
#	econf $(use_with jack)
#}

src_install() {
	dobin IanniX
	doicon ${FILESDIR}/iannix.png
	make_desktop_entry IanniX IanniX iannix AudioVideo
	dodoc Readme.txt

	if use doc; then
		docinto Documentation
		docompress -x /usr/share/doc/${PF}/Documentation
		dodoc -r Documentation/*
	fi
	if use examples; then
		docinto Examples
		docompress -x /usr/share/doc/${PF}/Examples
		dodoc -r ${S}/Examples/*

		docinto Patches
		docompress -x /usr/share/doc/${PF}/Patches
		dodoc -r ${S}/Patches/*
	fi
}

pkg_postinst() {
	elog "Run IanniX with /usr/bin/IanniX"

	if use examples; then
		elog "Examples and sample patches for PureData,"
		elog "Max/MSP, and Processing can be found in:"
		elog "/usr/share/doc/${PF}/Examples"
		elog "/usr/share/doc/${PF}/Patches"
	fi
	if use doc; then
		elog "A handy HTML usage guide can be found in"
		elog "/usr/share/doc/${PF}/Documentation"
	fi
}
