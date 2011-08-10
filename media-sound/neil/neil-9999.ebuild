# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit mercurial scons-utils

DESCRIPTION="Buzz/Aldrin-inspired tracker"
HOMEPAGE="http://sites.google.com/site/neilsequencer"
SRC_URI=""
EHG_REPO_URI="https://bitbucket.org/bucket_brigade/neil"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# jackd2 only?
DEPEND="app-text/docbook-xml-dtd:4.5
	${RDEPEND}"
RDEPEND="app-text/xmlto
	dev-libs/boost
	dev-python/numpy
	media-libs/alsa-lib
	media-libs/flac
	media-libs/ladspa-sdk
	media-libs/liblo
	media-libs/libmad
	media-libs/libsndfile[alsa]
	media-sound/jack-audio-connection-kit
	sci-libs/fftw:3.0
	sys-libs/zlib"

src_configure() {
	escons configure
}

src_compile() {
	escons
}

src_install() {
	escons PREFIX=/usr \
	DESTDIR="${D}" \
	DOC_PATH="${D}/${PREFIX}/share/doc/${PF}" install
}
