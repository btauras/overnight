# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="git://github.com/nightmorph/rove.git"

inherit eutils git-2 multilib

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

RDEPEND="${DEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf --prefix=/usr
}

#src_install() {
#	emake BINDIR="${D}"/usr/bin LIBDIR="${D}"/usr/$(get_libdir) \
#		INCDIR="${D}"/usr/include MANDIR="${D}"/usr/share/man \
#		PKGCONFIGDIR="${D}"/usr/$(get_libdir)/pkgconfig install
#	dodoc README
#}
