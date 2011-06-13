# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit qt4-r2

DESCRIPTION="Graphical sequencer for digital art, using realtime OSC events to control audio and video"
HOMEPAGE="http://www.iannix.org"
SRC_URI="http://iannix.org/en/download/${PN}_sources__0_8_2.zip"

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples jack"

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

#src_compile() {
#	# make amd64 compile
#	use amd64 && esed_check -i -e "45s|||" \
#		-e "60s|||" \
#		-e "61s|||" \
#		src/network/OSCin/osc/OscReceivedElements.cpp
#	/usr/bin/qmake || die "qmake failed"
#	emake || die "make failed"
#}

#src_install() {
#	dobin bin/IanniX
#	dodoc Readme.txt
#	make_desktop_entry IanniX "IanniX"
#	if use doc; then
#		insinto /usr/share/doc/${P}
#		doins "${DISTDIR}"/*.pdf
#	fi
#	if use examples; then
#		mv "${WORKDIR}/IanniX Processing Examples" "${D}"/usr/share/doc/"${P}"
#	fi
#}

#pkg_postinst() {
#	einfo "You can start IanniX with"
#	einfo ""
#	einfo "/usr/bin/IanniX"
#	einfo ""

#	if use examples; then
#		einfo "The examples have been installed to /usr/share/doc/${P}"
#	fi

#	if use doc; then
#		einfo "For documentation read /usr/share/doc/${P}/IanniX-Tutorial.pdf"
#	fi
#}
