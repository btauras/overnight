# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git

DESCRIPTION="Moblin GTK+ Engine"
HOMEPAGE="http://git.moblin.org/cgit.cgi/moblin-gtk-engine"
#SRC_URI="http://git.moblin.org/cgit.cgi/${PN}/snapshot/${P}.tar.gz"
EGIT_REPO_URI="git://git.moblin.org/moblin-gtk-engine"
EGIT_PROJECT="moblin-gtk-engine"
EGIT_BOOTSTRAP="autogen.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

#S=${WORKDIR}/rezlooks-${PV}

#src_compile() {
#	econf --disable-dependency-tracking --enable-animation
#	emake || die "make failed."
#}

src_configure() {
	econf || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
