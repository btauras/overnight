# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2

DESCRIPTION="PureData external for bonjour/zeroconf integration"
HOMEPAGE="https://github.com/murr/simplebonjour"
EGIT_REPO_URI="git://github.com/murr/simplebonjour"
SRC_URI="http://sourceforge.net/projects/pure-data/files/pd-extended/0.42.5/Pd-0.42.5-extended.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="=pd-base/pd-extended-0.42.5
	|| ( net-dns/avahi[mdnsresponder-compat] net-misc/mDNSResponder )"

src_prepare() {
	cd ${S}
	sed /strip/d -i makefile
}

src_compile() {
	emake \
	PDROOT="${WORKDIR}/pd-extended-0.42.5" \
	PDSRCDIR="${WORKDIR}/pd-extended-0.42.5/pd/src" \
	PDLIBDIR="${WORKDIR}/pd-extended-0.42.5/pd/bin" \
	pd_linux
}

src_install() {
	dodir /usr/$(get_libdir)/pd-extended/extra/simplebonjour
	insinto /usr/$(get_libdir)/pd-extended/extra/simplebonjour
	doins *.pd_linux *.c
}
