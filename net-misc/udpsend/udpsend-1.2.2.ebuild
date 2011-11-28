# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Send UDP packets via IPv4"
HOMEPAGE="http://www.net.princeton.edu/software/udpsend/"
SRC_URI="http://www.net.princeton.edu/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-libs/libnet:1.1"
RDEPEND="${DEPEND}"

pkg_postinst() {
	elog "You must run ${PN} as root or else setup"
	elog "your kernel to allow regular users to send"
	elog "raw network packets. Look for this option:"
	elog "CAP_NET_RAW"
}
