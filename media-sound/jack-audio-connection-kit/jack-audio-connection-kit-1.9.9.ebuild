# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit multilib

DESCRIPTION="Next-gen low-latency audio server"
HOMEPAGE="http://www.jackaudio.org"
SRC_URI="http://www.jackaudio.org/downloads/jack-${PV}.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa +dbus debug doc ieee1394 +32bit"

RDEPEND="dev-util/pkgconfig"

DEPEND="${RDEPEND}
        alsa? ( media-libs/alsa-lib )
        doc? ( app-doc/doxygen )
        dbus? ( sys-apps/dbus )
        ieee1394? ( media-libs/libffado )"

S="${WORKDIR}/jack-${PV}/jack-${PV}.5"

src_compile() {
	local myconf="--prefix=/usr --destdir=${D}"
	use alsa && myconf="${myconf} --alsa"
	use dbus && myconf="${myconf} --dbus --classic"
	! use dbus && myconf="${myconf} --classic"
	use debug && myconf="${myconf} -d debug"
	use doc && myconf="${myconf} --doxygen"
	use ieee1394 && myconf="${myconf} --firewire"
	use 32bit && myconf="${myconf} --mixed"

	elog "Running \"./waf configure ${myconf}\" ..."
	./waf configure ${myconf} || die "waf configure failed"
	./waf build ${MAKEOPTS} || die "waf build failed"
}

src_install() {
	ln -s ../../html build/default/html
	./waf --destdir="${D}" install || die "waf install failed"
}
