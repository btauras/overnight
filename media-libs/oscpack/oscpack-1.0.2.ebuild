# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils versionator
MY_PV=$(replace_all_version_separators '_')

DESCRIPTION="Set of C++ classes for packing and unpacking OSC packets"
HOMEPAGE="http://www.rossbencina.com/code/oscpack"
SRC_URI="http://${PN}.googlecode.com/files/${PN}_${MY_PV}.zip"
RESTRICT="mirror"

LICENSE="AS-IS"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="${DEPEND}"
DEPEND="app-arch/unzip"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_compile() {
	sed -i -e "s:/usr/local:/usr:" -e "s/mkdir bin/mkdir -p bin/g" \
		"${S}/Makefile" || die "sed failed"
	if use ppc; then
	    sed -i -e \
		"s:ENDIANESS=OSC_HOST_LITTLE_ENDIAN:ENDIANESS=OSC_HOST_BIG_ENDIAN:" \
		"${S}/Makefile" || die "sed ppc failed"
	fi
	# fix a DT_TEXREL warning on x86 and made it to compile on amd64 and
	# possibely on ppc:
	sed -i -e "s:-Wall -O3:-Wall -O3 -fPIC:" "${S}/Makefile"

	emake
	emake lib
}

src_install() {
	dodoc CHANGES README TODO

	dolib liboscpack.so.1.0.2
	insinto /usr/include/oscpack/ip
	doins ip/*.h

	insinto /usr/include/oscpack/osc
	doins osc/*.h

	insinto /usr/include/oscpack/osc
	doins osc/*.cpp

	insinto /usr/include/oscpack/ip
	doins ip/*.cpp

	insinto /usr/include/oscpack/ip/posix
	doins ip/posix/*.cpp
}
