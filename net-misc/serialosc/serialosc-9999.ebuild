# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="git://github.com/monome/serialosc.git"

inherit eutils git-2 multilib

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
	|| ( net-dns/avahi[mdnsresponder-compat] net-misc/mDNSResponder )
	sys-fs/udev"

RDEPEND="${DEPEND}
	dev-util/pkgconfig"

src_install() {
	emake BINDIR="${D}"/usr/bin LIBDIR="${D}"/usr/$(get_libdir) \
		INCDIR="${D}"/usr/include MANDIR="${D}"/usr/share/man \
		PKGCONFIGDIR="${D}"/usr/lib/pkgconfig install
	dodoc README
}
