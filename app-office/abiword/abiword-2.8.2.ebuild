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
IUSE="+clipart +collab debug emacs gnomevfs service +spell sugar 
tcp telepathy +templates vim xmpp"

## The 'wordperfect' USE flag requires >=libwps-0.1.0, not yet in Portage:
## http://libwps.sourceforge.net
## http://bugs.gentoo.org/284159
## It also requires app-text/libwpd

IUSE_ABIWORD_PLUGINS="aiksaurus applix babelfish bmp clarisworks command
docbook eml freetranslation garble gda gdict gimp goffice google hancom hrtext
iscii kword latex link-grammar loadbindings mathview mht mif mswrite
opendocument openwriter openxml opml ots paint passepartout pdb pdf presentation
psion rsvg s5 sdw t602 urldict wikipedia wmf wml wpg xslfo"
## AbiWord requires librsvg. The SVG plugin is optional, 
## but it also requires librsvg, hence the use_enable flag for it.

for i in ${IUSE_ABIWORD_PLUGINS} ; do IUSE+=" abiword_plugins_$i" ; done

COLLAB_COMMON=""

RDEPEND="app-text/wv
	dev-libs/fribidi
	dev-libs/glib:2
	dev-libs/popt
	gnome-base/librsvg
	>=gnome-extra/libgsf-1.14.17[gtk]
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	>=x11-libs/gtk+-2.14
	x11-libs/cairo
	x11-libs/pango[X]
	collab? ( ( dev-libs/boost net-libs/libsoup[ssl] )
		service? ( dev-cpp/asio )
		sugar? ( dev-libs/dbus-glib )
		tcp? ( dev-cpp/asio )
		telepathy? ( dev-libs/libxml2
			>=net-im/empathy-2.27
			net-im/telepathy-mission-control
			net-libs/telepathy-glib )
		xmpp? ( net-libs/loudmouth )		
		)
	gnomevfs? ( gnome-base/gnome-vfs )
	spell? ( app-text/enchant )

	abiword_plugins_aiksaurus? ( >=app-text/aiksaurus-1.0 )
	abiword_plugins_command? ( sys-libs/readline )
	abiword_plugins_garble? ( dev-libs/libxml2 )
	abiword_plugins_gda? ( gnome-extra/libgda
		gnome-extra/libgnomedb )
	abiword_plugins_gdict? ( gnome-base/libgnomeui
		gnome-extra/gnome-utils )
	abiword_plugins_gimp? ( media-gfx/gimp )
	abiword_plugins_goffice? ( x11-libs/goffice:0.8 )
	abiword_plugins_latex? ( dev-libs/libxslt )
	abiword_plugins_link-grammar? ( dev-libs/link-grammar )
	abiword_plugins_loadbindings? ( dev-libs/libxml2 )
	abiword_plugins_mathview? ( x11-libs/libmathview )
	abiword_plugins_mht? ( app-text/htmltidy 
		dev-libs/libxml2 )
	abiword_plugins_openxml? ( dev-libs/boost )
	abiword_plugins_ots? ( app-text/ots )
	!amd64? ( abiword_plugins_psion? ( app-text/psiconv ) )
	abiword_plugins_wmf? ( media-libs/libwmf )
	abiword_plugins_wpg? ( app-text/libwpd
		media-libs/libwpg )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
		## AbiWord options
		G2CONF="${G2CONF}
		$(use_enable clipart)
		$(use_enable collab)
		$(use_enable debug)
		$(use_enable emacs emacs-keybinding)
		$(use_with gnomevfs)
		$(use_enable spell)
		$(use_enable templates)
		$(use_enable vim vi-keybinding)
		--with-gio
		--enable-print"
}

src_configure() {
		local plugins=""
		for i in ${IUSE_ABIWORD_PLUGINS} ; do 
			use abiword_plugins_$i && plugins+=" $i" ;
		done
		plugins=${plugins# }
		[[ -z ${plugins} ]] && plugins="no"
		gnome2_src_configure --enable-plugins="${plugins}"
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
