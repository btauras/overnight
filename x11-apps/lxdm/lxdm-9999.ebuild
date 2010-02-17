# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI="2"
inherit subversion

DESCRIPTION="LXDM - GUI login manager for LXDE"
HOMEPAGE="http://lxde.sf.net/"
ESVN_REPO_URI="https://lxde.svn.sourceforge.net/svnroot/lxde/trunk/lxdm/"
ESVN_BOOTSTRAP="./autogen.sh"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="0"
IUSE="+X nls"

RDEPEND="x11-libs/gtk+:2
	 dev-libs/glib:2
	 X? ( x11-libs/libX11
              x11-libs/libXmu )
	 sys-libs/pam
	 sys-auth/consolekit"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	>=dev-util/intltool-0.40.0"

src_configure() {
        econf $(use_with X x) \
	      $(use nls || --disable-nls)
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README || die "dodoc failed"
}

pkg_postinst() {
        echo
        elog "LXDM in the early stages of development!"
        elog "Today /etc/lxdm/xsession is not compatible with Gentoo"
        elog "and you need to change it to start X Session correctly."
}
