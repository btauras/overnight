# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils

DESCRIPTION="An Xfire plugin for Pidgin"
HOMEPAGE="http://gfire.sourceforge.net/"
SRC_URI="mirror://sourceforge/gfire/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE="dbus debug +libnotify"

RDEPEND="dbus? ( dev-libs/dbus-glib )
	libnotify? ( x11-libs/libnotify )
	net-im/pidgin[gtk]
	x11-libs/gtk+:2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's/NotifyNotification *notification =	notify_notification_new(p_title, p_msg, NULL, NULL);/NotifyNotification	*notification = notify_notification_new(p_title, p_msg, NULL);/g' -e 's/notification = notify_notification_new(p_title, p_msg, NULL, NULL);/notification = notify_notification_new(p_title, p_msg, NULL);/g' src/gf_util.c
}

src_configure() {
	econf \
	$(use_enable dbus dbus-status) \
	$(use_enable debug) \
	$(use_enable libnotify) \
	|| die "configure failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README VERSION
}
