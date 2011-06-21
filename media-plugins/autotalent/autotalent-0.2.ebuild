# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit multilib

DESCRIPTION="Realtime pitch correction plugin for LADSPA"
HOMEPAGE="http://web.mit.edu/tbaran/www/autotalent.html"
SRC_URI="http://web.mit.edu/tbaran/www/${P}.tar.gz"

LICENSE="GPL-2 as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/ladspa-sdk"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/$(get_libdir)/ladspa
	doins *.so
	dodoc README
}
