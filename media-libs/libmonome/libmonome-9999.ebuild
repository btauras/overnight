# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="git://github.com/monome/libmonome.git"

inherit eutils git-2 multilib

DESCRIPTION="A library for easy interaction with monome devices"
HOMEPAGE="http://github.com/monome/libmonome"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python"

DEPEND="media-libs/liblo
	sys-fs/udev
	python? ( || ( dev-lang/python:2.7 ) ( dev-lang/python:2.6 ) )"

RDEPEND="${DEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf $(use_enable python) \
	--prefix=/usr
}

src_install() {
	emake BINDIR="${D}"/usr/bin LIBDIR="${D}"/usr/$(get_libdir) \
		INCDIR="${D}"/usr/include MANDIR="${D}"/usr/share/man \
		PKGCONFIGDIR="${D}"/usr/$(get_libdir)/pkgconfig install
	dodoc README
}
