# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator
MY_PV=$(delete_all_version_separators)

DESCRIPTION="Generates SVG wallpaper based on the current weather, season, time
of day, and more."
HOMEPAGE="http://dynwallpaper.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/project/dynwallpaper/dynwallpaper-${PV}/${PV}/${PN}${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/pymetar
	dev-python/pygtk"

DEPEND="sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" \
		install || die "emake install failed"
	dodoc AUTHORS README README-themes || die "dodoc failed"
}
