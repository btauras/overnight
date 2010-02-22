# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/logjam/logjam-4.5.3.ebuild,v 1.2 2006/01/12 23:45:26 compnerd Exp $

EAPI="2"

EGIT_REPO_URI="git://github.com/nightmorph/LogJam.git"
EGIT_BOOTSTRAP="autogen.sh"

inherit eutils git

DESCRIPTION="GTK2-based LiveJournal client"
HOMEPAGE="http://logjam.danga.com/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk gtkhtml spell sqlite svg"

RDEPEND="dev-libs/dbus-glib
	dev-libs/libxml2
	net-misc/curl
	dev-libs/dbus-glib
	gtk? ( x11-libs/gtk+:2 )
	gtkhtml? ( gnome-extra/gtkhtml:3.14 )
	spell? ( app-text/gtkspell )
	sqlite? ( dev-db/sqlite:3 )
	svg? ( gnome-base/librsvg )"

DEPEND="${RDEPEND}
	dev-perl/yaml
	dev-util/intltool
	dev-util/pkgconfig"

src_configure() {
	econf \
	$(use_with gtk) \
	$(use_with gtkhtml gtkhtml36) \
	$(use_with spell gtkspell) \
	$(use_with svg librsvg) \
	$(use_with sqlite sqlite3) \
	--with-dock \
	--without-xmms || die "econf failed"
}
src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog doc/README doc/TODO || die "dodoc failed"
}
