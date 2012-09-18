# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils multilib scons-utils subversion

DESCRIPTION="Library for accessing BeBoB IEEE1394 devices"
HOMEPAGE="http://www.ffado.org"

ESVN_REPO_URI="http://subversion.ffado.org/ffado/trunk/libffado"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="0"
IUSE="+dbus-server debug +qt4"

RDEPEND="dev-cpp/libxmlpp:2.6
	dev-libs/libconfig
	media-libs/alsa-lib
	media-libs/libiec61883
	sys-apps/dbus
	sys-libs/libavc1394
	sys-libs/libraw1394
	dbus-server? ( dev-libs/dbus-c++ )
	qt4? (
		|| ( x11-libs/qt-core x11-libs/qt-gui )
		dev-python/PyQt4
		dev-python/dbus-python )"

DEPEND="${RDEPEND}"

src_configure() {
	local myconf=""

	use debug \
		&& myconf="${myconf} DEBUG=True ENABLE_OPTIMIZATIONS=False" \
		|| myconf="${myconf} DEBUG=False ENABLE_OPTIMIZATIONS=True"
}

## workaround: buildprocess calls "jackd --version",
## which accesses /dev/snd/control*
src_compile() {
	addpredict /dev/snd

	escons \
		PREFIX=/usr \
		LIBDIR=/usr/$(get_libdir) \
		${myconf} || die
}

src_install () {
	escons DESTDIR="${D}" WILL_DEAL_WITH_XDG_MYSELF="True" install || die
	dodoc AUTHORS ChangeLog README

	if use qt4; then
		newicon "support/xdg/hi64-apps-ffado.png" "ffado.png"
		newmenu "support/xdg/ffado.org-ffadomixer.desktop" "ffado-mixer.desktop"
	fi
}
