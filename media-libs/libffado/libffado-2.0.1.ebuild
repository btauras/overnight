# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils multilib scons-utils
RESTRICT="mirror"

DESCRIPTION="Successor for freebob: Library for accessing BeBoB IEEE1394 devices"
HOMEPAGE="http://www.ffado.org"
SRC_URI="http://www.ffado.org/files/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug +qt4"

RDEPEND="media-libs/alsa-lib
	dev-cpp/libxmlpp:2.6
	sys-libs/libraw1394
	media-libs/libiec61883
	sys-libs/libavc1394
	sys-apps/dbus
	qt4? (
		|| ( x11-libs/qt-core x11-libs/qt-gui )
		dev-python/PyQt4
		dev-python/dbus-python )"

DEPEND="${RDEPEND}"

src_compile () {
	local myconf=""

	use debug \
		&& myconf="${myconf} DEBUG=True ENABLE_OPTIMIZATIONS=False" \
		|| myconf="${myconf} DEBUG=False ENABLE_OPTIMIZATIONS=True"

	scons \
		PREFIX=/usr \
		LIBDIR=/usr/$(get_libdir) \
		${myconf} || die
}

src_install () {
	scons DESTDIR="${D}" WILL_DEAL_WITH_XDG_MYSELF="True" install || die
	dodoc AUTHORS ChangeLog README

	if use qt4; then
		newicon "support/xdg/hi64-apps-ffado.png" "ffado.png"
		newmenu "support/xdg/ffado.org-ffadomixer.desktop" "ffado-mixer.desktop"
	fi
}

pkg_postinst() {
	ewarn "Important: This version of FFADO works on the new firewire-stack,"
	ewarn "and no longer needs the raw1394/ohci1394/ieee1394 modules."
}
