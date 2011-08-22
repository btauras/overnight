# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils scons-utils

DESCRIPTION="MIDI-controlled virtual sampler."
HOMEPAGE="http://tardigrade-inc.com/index.php/En/Tapeutape"
SRC_URI="http://www.tardigrade-inc.com/uploads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui +lash"

DEPEND="dev-libs/libxml2
	media-libs/libsamplerate
	media-libs/libsndfile
	media-sound/jack-audio-connection-kit"
RDEPEND="gui? ( =x11-libs/fltk-1.1.10* )
	lash? ( media-sound/lash )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-install.patch
	sed -i "s,CPPFLAGS=',CPPFLAGS=' -I/usr/include/fltk-1 ,"  SConstruct

	cd src/base
	sed -i "/#define tapeutape_h/ a\ \n#include <limits>" tapeutape.h
}

src_compile() {
	escons \
	$(use_scons gui) \
	$(use_scons lash)
}

src_install() {
	escons bin_dir="${D}/usr/bin" \
	desktop_dir="${D}/usr/share/applications" \
	icon_dir="${D}/usr/share/pixmaps" \
	install
}
