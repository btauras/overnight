# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit cmake-utils elisp-common

DESCRIPTION="An environment and a programming language for real time audio synthesis and algorithmic composition"
HOMEPAGE="http://supercollider.sourceforge.net"
MY_PN="SuperCollider"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://sourceforge/${PN}/Source/${PV}/${MY_P}-Source-linux.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="curl debug emacs gedit2 gedit3 portaudio +qt sse sse4 vim wii +zeroconf"

RDEPEND="${DEPEND}"
DEPEND="dev-libs/icu
	dev-util/pkgconfig
	media-libs/alsa-lib
	media-libs/libsndfile
	media-sound/jack-audio-connection-kit
	sci-libs/fftw:3.0
	sys-libs/readline
	x11-libs/libXt
	curl? ( net-misc/curl )
	emacs? ( virtual/emacs )
	gedit2? ( <app-editors/gedit-3 )
	gedit3? ( >app-editors/gedit-2 )
	portaudio? ( media-libs/portaudio )
	qt? ( x11-libs/qt-webkit )
	vim? ( || ( app-editors/vim[ruby] )
		( app-editors/gvim[ruby] ) )
	wii? ( app-misc/cwiid )
	zeroconf? ( net-dns/avahi )"

## note that SC_ED builds the plugin for gedit3; SC_ED=2 enables the gedit2
## plugin (currently 2.x is stable on gentoo, as of august 2012

## things not really optional, thus removed from IUSE:
## alsa, readline, X
## upstream also really insists on avahi, libsndfile, qt activated

S="${WORKDIR}/${MY_PN}-Source"

src_configure() {
	tc-export CC CXX
	mkdir -p "${D}"

	local mycmakeargs="
		$(cmake-utils_use curl CURL)
		$(cmake-utils_use debug SC_MEMORY_DEBUGGING)
		$(cmake-utils_use emacs SC_EL)
		$(use gedit2 && echo -DSC_ED=2)
		$(cmake-utils_use gedit3 SC_ED)
		$(cmake-utils_use sse SSE)
		$(cmake-utils_use sse4 SSE41)
		$(cmake-utils_use qt SC_QT)
		$(cmake-utils_use vim SC_VIM)
		$(cmake-utils_use wii SC_WII)"

	cmake-utils_src_configure
}

src_install() {
# When installing into /usr/local (which is the default), gedit won't find
# the plugin since it only looks in /usr. To fix this, simply symlink
# the plugin-files to ~/.local/share/gedit/plugins/:
#
# $ mkdir -p ~/.local/share/gedit/plugins
# $ cd ~/.local/share/gedit/plugins
# $ ln -sf /usr/local/lib/gedit/plugins/supercollider.plugin .
# $ ln -sf /usr/local/lib/gedit/plugins/supercollider.py .

	# Main install
	cmake-utils_src_install || die "install failed"

	# Upstream Documentation
	dodoc README_LINUX.txt README.txt

	mv editors/scel/README editors/scel/README-scel
	dodoc editors/scel/README-scel
	mv editors/sced/README editors/sced/README-sced
	dodoc editors/sced/README-sced
	mv editors/scvim/README editors/scvim/README-scvim
	dodoc editors/scvim/README-scvim

	# Gentoo documentation
	sed -e "s:@DOCBASE@:/usr/share/doc/${PF}:" < "${FILESDIR}/README-gentoo.txt" | gzip > "${D}/usr/share/doc/${PF}/README-gentoo.txt.gz"

	use emacs && elisp-site-file-install "${FILESDIR}/70scel-gentoo.el"

	## TODO: install sced, scel, scvim
	# these might need to be split out into their own ebuilds, since
	# users don't actually need to compile all of supercollider. needs
	# a separate source tree sub-checkout, though. could then put in an
	# IUSE with RDEP on each editor plugin.
}

pkg_postinst() {
	elog "Notice: SuperCollider is not very intuitive to get up and running."
	elog "The best course of action to make sure that the installation was"
	elog "successful and get you started with using SuperCollider is to take"
	elog "a look through /usr/share/doc/${PF}/README-gentoo.txt.gz"
}
