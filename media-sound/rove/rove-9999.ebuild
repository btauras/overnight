# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

EGIT_REPO_URI="git://github.com/nightmorph/rove.git"

inherit waf-utils git-2
NO_WAF_LIBDIR=yes

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
