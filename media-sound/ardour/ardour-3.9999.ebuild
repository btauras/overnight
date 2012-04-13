# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils fdo-mime flag-o-matic toolchain-funcs subversion

DESCRIPTION="Digital Audio Workstation"
HOMEPAGE="http://ardour.org/"
ESVN_REPO_URI="http://subversion.ardour.org/svn/ardour2/branches/3.0"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="curl debug nls +lv2 sse tranzport +vst wiimote"

RDEPEND="dev-cpp/glibmm:2
	dev-cpp/gtkmm:2.4
	dev-cpp/libgnomecanvasmm:2.6
	dev-libs/glib:2
	dev-libs/libsigc++:2
	dev-libs/libxml2:2
	dev-libs/libxslt
	gnome-base/libgnomecanvas
	media-libs/alsa-lib
	media-libs/aubio
	media-libs/flac
	media-libs/freetype:2
	media-libs/libart_lgpl
	media-libs/liblo
	>=media-libs/liblrdf-0.4.0-r20
	media-libs/libsamplerate
	media-libs/libsndfile
	media-libs/raptor:2
	>=media-libs/rubberband-1.6.0
	media-libs/vamp-plugin-sdk
	>=media-sound/jack-audio-connection-kit-0.120
	sci-libs/fftw:3.0
	x11-libs/gtk+:2
	x11-libs/pango
	x11-libs/cairo
	virtual/libusb:0
	curl? ( net-misc/curl )
	lv2? ( media-libs/lilv
			media-libs/suil )"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

# get svn revision; must be passed to source
src_unpack() {
	subversion_src_unpack
	cd "${S}"
	subversion_wc_info
	echo '#include "ardour/svn_revision.h"' > libs/ardour/svn_revision.cc
	echo "namespace ARDOUR { const char* svn_revision=\"$ESVN_WC_REVISION\"; }" >> libs/ardour/svn_revision.cc
	echo >> libs/ardour/svn_revision.cc
}

src_configure() {
	tc-export CC CXX

	./waf configure \
		--prefix=/usr \
		--freedesktop \
		--noconfirm \
		$(use curl && echo "--freesound") \
		$(use debug && echo "--debug" || echo "--optimize") \
		$(use lv2 && echo "--lv2") \
		$(use nls && echo "--nls" || echo "--no-nls") \
		$(use sse && echo "--fpu-optimization") \
		$(use vst && echo "--lxvst") \
		|| die "config failed"
		## 1. altivec is only for ppc OSX. doesn't work on ppc linux! the only
		## available cpu instruction optimization is sse

		## 2. it's not possible to build support for 32-bit windows VSTs
		## if you're on 64-bit linux. only native linux VSTs for your arch
		## are allowed; e.g. 64-bit VSTs in a 64-bit Ardour.
}

src_compile() {
	./waf || die "build failed"
}

src_install() {
	./waf --destdir="${D}" install

	doman ${PN}.1
	newicon icons/icon/ardour_icon_mac.png ${PN}.png
	make_desktop_entry ardour3 Ardour ardour AudioVideo;
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_mime_desktop_database_update

	elog "A message from Ardour's developers:"
	elog ""
	elog "This is an alpha version of Ardour 3.0."
	elog "You are respectfully requested NOT to ask"
	elog "for assistance with build issues and not"
	elog "to report issues with Ardour 3.0 on the"
	elog "forums at ardour.org. Please use IRC, the"
	elog "bug tracker and/or the ardour mailing"
	elog "lists (-dev or -user). Thanks for your"
	elog "co-operation with our development process."
}
