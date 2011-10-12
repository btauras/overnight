# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils git-2

DESCRIPTION="Configurator software for the Korg nanoSERIES of MIDI controllers"
HOMEPAGE="https://github.com/royvegard/Nano-Basket"
EGIT_REPO_URI="git://github.com/royvegard/Nano-Basket"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/pyalsa
	dev-python/pygtk"

S=${WORKDIR}/Nano-Basket

src_install() {
	dodir /usr/share/${PN}/
	cp -R "${S}"/*.py "${D}"/usr/share/${PN}/ || die "cp failed"
	insinto /usr/bin
	dosym /usr/share/${PN}/nano_basket_main.py /usr/bin/nanobasket || die "sym failed"
	make_desktop_entry ${PN} "Nano Basket" nanobasket Audio;
}
