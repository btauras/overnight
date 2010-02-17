# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-2.6.8.ebuild,v 1.1 2009/03/15 01:00:27 eva Exp $

EAPI="2"

inherit alternatives eutils gnome2 versionator

MY_MAJORV=$(get_version_component_range 1-2)

DESCRIPTION="Fully featured yet light and fast cross platform word processor"
HOMEPAGE="http://www.abisource.com/"
SRC_URI="http://www.abisource.com/downloads/${PN}/${PV}/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug gnome gvfs office spell"

RDEPEND="app-text/wv
	dev-libs/fribidi
	dev-libs/glib:2
	dev-libs/popt
	gnome-base/librsvg
	gnome-extra/libgsf
	media-libs/libpng
	sys-libs/zlib
	>=x11-libs/gtk+-2.14
	x11-libs/pango[X]
	gnome? (
		gnome-extra/gucharmap
		gnome-base/gnome-vfs )
	gvfs? ( gnome-base/gvfs )
	office? ( x11-libs/goffice:0.6 )
	spell? ( app-text/enchant )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
		G2CONF="${G2CONF}
		$(use_enable debug)
		$(use_with gnome gucharmap)
		$(use_with gnome gnomevfs)
		$(use_with gvfs gio)
		$(use_with office goffice)
		$(use_enable spell)
		--enable-print"
}

src_install() {
	gnome2_src_install

	mv "${D}/usr/bin/abiword" "${D}/usr/bin/AbiWord-${MY_MAJORV}"
	mv "${D}/usr/share/abiword-2.8/applications/abiword.desktop" \
		"${D}/usr/share/applications/abiword.desktop"
	sed "s:Exec=abiword:Exec=abiword-${MY_MAJORV}:" \
		-i "${D}"/usr/share/applications/abiword.desktop || die
	dosym AbiWord-${MY_MAJORV} /usr/bin/abiword-${MY_MAJORV}

	dodoc *.TXT user/wp/readme.txt
}

pkg_postinst() {
	gnome2_pkg_postinst

	alternatives_auto_makesym "/usr/bin/abiword" "/usr/bin/abiword-[0-9].[0-9]"
}
