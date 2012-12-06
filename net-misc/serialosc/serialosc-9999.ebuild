# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="git://github.com/monome/serialosc"

inherit waf-utils git-2
NO_WAF_LIBDIR=yes

DESCRIPTION="A zeroconf-enabled OSC server for monome devices"
HOMEPAGE="http://github.com/monome/serialosc"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/confuse
	media-libs/liblo
	media-libs/libmonome
	net-dns/avahi[mdnsresponder-compat]
	sys-fs/udev"

RDEPEND="${DEPEND}
	dev-util/pkgconfig"
