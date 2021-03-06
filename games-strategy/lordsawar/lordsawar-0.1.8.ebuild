# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils games

DESCRIPTION="A free clone of WarLords II"
HOMEPAGE="http://www.lordsawar.com/"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="editor nls pbm +sound"

RDEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/libglademm-2.4
	dev-libs/libtar
	media-libs/sdl-image
	sound? ( media-libs/sdl-mixer[vorbis] )
	>=net-libs/gnet-2
	>=dev-libs/libsigc++-2
	>=dev-libs/expat-2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-libs/boost
	nls? ( sys-devel/gettext )"

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-sdltest \
		$(use_enable editor) \
		$(use_enable nls) \
		$(use_enable pbm) \
		$(use_enable sound) \
		|| die "something USE-related failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}"/usr/share/locale/locale.alias
	doicon dat/various/${PN}.png
	make_desktop_entry ${PN} LordsAWar
	if use editor ; then
		doicon dat/various/${PN}_editor.png
		make_desktop_entry ${PN}_editor "LordsAWar Editor" ${PN}_editor
	fi
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
