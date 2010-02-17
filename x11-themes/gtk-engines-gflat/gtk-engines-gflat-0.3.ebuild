# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#inherit autotools

DESCRIPTION="gFlat GTK+ Engine"
HOMEPAGE="http://www.gnome-look.org/content/show.php?content=39916"
SRC_URI="http://gnome-look.org/CONTENT/content-files/39916-gflat-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.19"

#S="${WORKDIR}/gflat-${PV}"

#src_unpack() {
#	unpack "${A}"
#	cd "${WORKDIR}"
#
#	tar -xjpf gflat-${PV}.tar.gz
#
#	mkdir "${WORKDIR}/gtkrc_themes"
#	tar -jxpf gtkrc_themes.tar.bz2 -C gtkrc_themes
#}

src_compile() {
	econf --enable-animation || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	# Install the themes
	cd "${WORKDIR}"/gtkrc_themes
	for x in $(ls)
	do
		insinto /usr/share/themes/$x/gtk-2.0
		doins $x/gtk-2.0/gtkrc || die "doins gtkrc failed"

		if [[ -e $x/gtk-2.0/panel.png ]]; then
			doins $x/gtk-2.0/panel.png || die "doins panel.png failed"
		fi
	done
}
