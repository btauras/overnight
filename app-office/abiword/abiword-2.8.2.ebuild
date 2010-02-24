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
IUSE="aiksaurus applix babelfish bmp clarisworks clipart collab
collab-backend-service collab-backend-sugar collab-backend-tcp
collab-backend-telepathy collab-backend-xmpp command debug docbook eml
freetranslation garble gda gdict gimp gnome goffice google grammar gvfs hancom
hrtext iscii loadbindings kword latex mathview mht mif mswrite  opendocument
openwriter openxml opml ots paint passepartout pdb pdf presentation psion
record-always s5 spell staroffice svg t602 templates urldict wikipedia wmf
wml wordperfect wpg xslfo"

IUSE_ENABLE_PLUGINS="applix babelfish bmp clarisworks command docbook
freetranslation gimp hancom iscii kword mht office openxml psion s5 t602 wmf
wml"
IUSE_WITH_PLUGINS="mht" # --with-libtidy
## do a 'for' loop for the plugins
## for i in ${IUSE_PLUGINS} ; do something ; done
IUSE="${IUSE_PLUGINS} foo"

COLLAB_COMMON="dev-libs/boost
	net-libs/libsoup[ssl]"

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
	## this is just to get the required libs for all the collab backends.
	## you still have to select one or more of your desired backends.
	gnome? ( gnome-base/gnome-vfs )
	gvfs? ( gnome-base/gvfs )
	spell? ( app-text/enchant )

	## Plugin dependencies
	aiksaurus? ( app-text/aiksaurus )
	collab-backend-service? (
		${COLLAB_COMMON} 
		dev-cpp/asio )
	collab-backend-sugar? (
		${COLLAB_COMMON}
		dbus-glib )
	collab-backend-tcp? (
		${COLLAB_COMMON}
		dev-cpp/asio )
	collab-backend-telepathy? (
		${COLLAB_COMMON}
		dev-libs/libxml2
		>=net-im/empathy-2.27
		net-im/telepathy-mission-control
		net-libs/telepathy-glib )
	collab-backend-xmpp? (
		${COLLAB_COMMON}
		net-libs/loudmouth )
	command? ( sys-libs/readline )
	garble? ( dev-libs/libxml2 )
	gda? ( gnome-extra/libgda
		gnome-extra/libgnomedb )
	gdict? ( gnome-base/libgnomeui
		gnome-extra/gnome-utils )
	gimp? ( media-gfx/gimp )
	goffice? ( x11-libs/goffice:0.6 )
	openxml? ( dev-libs/boost )
	!amd64? ( psion? ( app-text/psiconv ) )
	"


DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
		## AbiWord options
		G2CONF="${G2CONF}
		$(use_enable clipart)
		$(use_enable debug)
		$(use_with gnome gnomevfs)
		$(use_with gvfs gio)
		$(use_enable spell)
		$(use_enable templates)
		--enable-print"

		## Plugins
		$(plugin_enable applix)
		$(plugin_enable babelfish)
		$(plugin_enable bmp)
		$(plugin_enable clarisworks)
		$(plugin_enable collab-backend-service)
		$(plugin_enable collab-backend-sugar)
		$(plugin_enable collab-backend-tcp)
		$(plugin_enable collab-backend-telepathy)
		$(plugin_enable collab-backend-xmpp)
		$(plugin_enable command)
		$(plugin_enable docbook)
		$(plugin_enable eml)
		$(plugin_enable freetranslation)
		$(plugin_enable garble)
		$(plugin_enable gda)
		$(plugin_enable gdict)
		$(plugin_enable gimp)
		$(plugin_enable google)
		$(plugin_enable grammar)
		$(plugin_enable hancom)
		$(plugin_enable hrtext)
		$(plugin_enable html)
		$(plugin_enable iscii) 
		$(plugin_enable loadbindings)
		$(plugin_enable kword)
		$(plugin_enable latex)
		$(plugin_enable mathview)
		$(plugin_enable mif)
		$(plugin_enable mswrite)
		$(plugin_enable goffice)
		$(plugin_enable opendocument)
		$(plugin_enable openwriter)
		$(plugin_enable openxml)
		$(plugin_enable opml)
		$(plugin_enable ots)
		$(plugin_enable paint)
		$(plugin_enable passepartout)
		$(plugin_enable pdb)
		$(plugin_enable pdf)
		$(plugin_enable presentation)
		$(plugin_enable psion)
		$(plugin_enable record-always)
		$(plugin_enable s5)
		$(plugin_enable staroffice)
		$(plugin_enable svg)
		$(plugin_enable t602)
		$(plugin_enable aiksaurus)
		$(plugin_enable urldict)
		$(plugin_enable wikipedia)
		$(plugin_enable wmf)
		$(plugin_enable wml)
		
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
