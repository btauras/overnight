# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

EGIT_REPO_URI="git://github.com/monome/libmonome.git"
#EGIT_BOOTSTRAP="autogen.sh"

#inherit eutils git
inherit git

DESCRIPTION="A library for easy interaction with monome devices"
HOMEPAGE="http://github.com/monome/libmonome"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python"

DEPEND="media-libs/liblo
	sys-fs/udev
	python? ( dev-lang/python:2.7 )"
	# enable python bindings

RDEPEND="${DEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf $(use_enable python) || die "econf failed"
}

#src_compile() {
#	emake || die "emake failed"
#}

src_install() {
	emake PREFIX="${D}" install || die "emake install failed"
	dodoc README || die "dodoc failed"
}
