# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="Kde4 plasmoid for monitoring emerge progress on Gentoo Linux"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=103928"
SRC_URI="http://dev.gentooexperimental.org/~hwoarang/projects/plasma-emergelog/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"

pkg_postinst() {
	kde4-base_pkg_postinst
	elog "You need to add your user to the 'portage' group"
	elog "in order to use this plasmoid. To do that, use"
	elog "the following command:"
	elog "gpasswd -a <your_user_here> portage"
}
