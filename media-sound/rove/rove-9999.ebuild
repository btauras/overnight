# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

EGIT_REPO_URI="git://github.com/wrl/rove"

#inherit waf-utils git-2
inherit git-2
#NO_WAF_LIBDIR=yes

DESCRIPTION="Music performance software for monomes"
HOMEPAGE="http://github.com/wrl/rove"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+libsamplerate"
RESTRICT="sandbox"

DEPEND="media-libs/liblo
	media-libs/libmonome
	media-libs/libsndfile
	media-sound/jack-audio-connection-kit
	libsamplerate? ( media-libs/libsamplerate )"

RDEPEND="${DEPEND}
	dev-util/pkgconfig
	net-misc/serialosc"

src_configure() {
	cd ${S}
	sed -i -e 's:"-Werror",\ ::g' wscript || die "wscript failed"
	./waf --prefix=/usr configure
}

src_compile() {
	./waf
}

src_install() {
	./waf --destdir=${D} install
}
