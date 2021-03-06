# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit games

DESCRIPTION="A tool for managing UT2kX cache, UMODs, etc"
HOMEPAGE="http://gunrealtools.sourceforge.net/"
SRC_URI="http://gunrealtools.sourceforge.net/${PN}-1.0-beta.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="gnome-base/libgnomeui
	x11-libs/gtk+:2"

S="${WORKDIR}/gunrealtools"

#src_unpack() {
#	unpack "${P/b/}-beta.tar.gz"
#	cd ${S}
#	epatch ${FILESDIR}/multiple-equal-signs.patch
#}

src_install() {
	emake DESTDIR="${D}" install || die "Failed installing"

	# We will use dodoc for this
	rm -rf "${D}/usr/doc"

	# We will use make_desktop_entry for this
	rm -rf "${D}/usr/share/gnome"

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO

	make_desktop_entry guts "gUnrealTools" \
	/usr/share/pixmaps/gunrealtools/gunrealtools-icon.png Game \
		|| die "failed creating desktop entry"
}
