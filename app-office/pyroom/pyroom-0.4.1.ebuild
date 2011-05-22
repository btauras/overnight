# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils

DESCRIPTION="A minimal word processor that lets you focus on writing"
HOMEPAGE="http://pyroom.org/"
SRC_URI="http://launchpad.net/${PN}/0.4/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome"

RDEPEND="dev-python/pygtk
	dev-python/pyxdg
	gnome? ( dev-python/gconf-python )"
DEPEND="sys-devel/gettext"

DOCS="AUTHORS CHANGELOG"
