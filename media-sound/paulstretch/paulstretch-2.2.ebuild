# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils fdo-mime toolchain-funcs

DESCRIPTION="Extreme sound stretcher"
HOMEPAGE="http://hypermammut.sourceforge.net/paulstretch"
SRC_URI="mirror://sourceforge/hypermammut/${P}-2.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="fftw jack"

DEPEND="dev-libs/mini-xml
	media-libs/audiofile
	media-libs/libmad
	media-libs/libvorbis
	media-libs/portaudio
	x11-libs/fltk:1
	fftw? ( sci-libs/fftw:3.0 )
	jack? ( media-sound/jack-audio-connection-kit
		sci-libs/fftw:3.0 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-2"

src_prepare() {
	epatch "${FILESDIR}/fix-mp3inputs.patch"
}

src_compile() {
	outfile=paulstretch
	fluid -c GUI.fl || die "generate gui failed"
	if use fftw ; then
		./compile_linux_fftw.sh || die "compile failed"
	elif use jack ; then
		./compile_linux_fftw_jack.sh || die "compile failed"
	else
		./compile_linux_kissfft.sh || die "compile failed"
	fi
}

src_install() {
	dobin paulstretch
	dodoc readme.txt
	make_desktop_entry paulstretch PaulStretch paulstretch AudioVideo;
}
