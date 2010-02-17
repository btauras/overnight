# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.5

inherit distutils

DESCRIPTION="A graphical journal with calendar, templates, tags, keyword searching, and export functionality"
HOMEPAGE="http://digitaldump.wordpress.com/projects/rednotebook/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="preview"

RDEPEND="dev-python/pyyaml
	>=dev-python/pygtk-2.13
	preview? ( dev-python/gtkmozembed-python )"
DEPEND="${RDEPEND}"

DOCS="AUTHORS README CHANGELOG"
