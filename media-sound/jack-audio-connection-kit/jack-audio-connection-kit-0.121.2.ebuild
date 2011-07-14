# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit flag-o-matic eutils multilib

DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://www.jackaudio.org"
SRC_URI="http://jackaudio.org/downloads/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="3dnow altivec +alsa celt coreaudio cpudetection doc debug examples +ieee1394 mmx +netjack oss +pam sse"

RDEPEND="
	media-libs/libsndfile
	sys-libs/ncurses
	celt? ( media-libs/celt )
	alsa? ( media-libs/alsa-lib )
	ieee1394? ( media-libs/libffado )
	netjack? ( media-libs/libsamplerate )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )
	pam? ( sys-auth/realtime-base )"

src_compile() {
	local myconf=""

	# CPU Detection (dynsimd) uses asm routines which requires 3dnow, mmx and sse.
	if use cpudetection && use 3dnow && use mmx && use sse ; then
		einfo "Enabling cpudetection (dynsimd). Adding -mmmx, -msse, -m3dnow and -O2 to CFLAGS."
		myconf="${myconf} --enable-dynsimd"
		append-flags -mmmx -msse -m3dnow -O2
	fi

	use doc || export ac_cv_prog_HAVE_DOXYGEN=false

	econf \
		$(use_enable ieee1394 firewire) \
		$(use_enable altivec) \
		$(use_enable alsa) \
		$(use_enable coreaudio) \
		$(use_enable debug) \
		$(use_enable mmx) \
		$(use_enable oss) \
		--disable-portaudio \
		$(use_enable sse)  \
		--with-html-dir=/usr/share/doc/${PF} \
		--disable-dependency-tracking \
		--with-default-tmpdir=/dev/shm \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS TODO README

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r "${S}/example-clients"
	fi
}
