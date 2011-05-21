# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

EGIT_REPO_URI="git://github.com/wrl/rove.git"
#EGIT_BOOTSTRAP="autogen.sh"

#inherit eutils git
inherit git

DESCRIPTION="Music performance software for monomes"
HOMEPAGE="http://github.com/wrl/rove"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+libsamplerate"

DEPEND="media-libs/liblo
	media-libs/libmonome
	media-libs/libsndfile
	media-sound/jack-audio-connection-kit
	libsamplerate? ( media-libs/libsamplerate )"
	# libsamplerate is used to change playback speed

RDEPEND="${DEPEND}
	dev-util/pkgconfig"

#src_configure() {
#	econf \
#	$(use_with gtk) \
#	$(use_with gtkhtml gtkhtml36) \
#	$(use_with spell gtkspell) \
#	$(use_with svg librsvg) \
#	$(use_with sqlite sqlite3) \
#	--with-dock \
#	--without-xmms || die "econf failed"
#}

#src_compile() {
#	emake || die "emake failed"
#}

src_install() {
	emake PREFIX="${D}" install || die "emake install failed"
	dodoc README || die "dodoc failed"
}
