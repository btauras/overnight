# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit eutils multilib

DESCRIPTION="TAL VST plugins, precompiled 32bit and 64bit versions"
HOMEPAGE="http://kunz.corrupt.ch http://sourceforge.net/projects/kxstudio/"
SRC_URI="http://sourceforge.net/projects/kxstudio/files/VST/tal-plugins_${PV}.tar.gz"

LICENSE="GPL"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+32bit +64bit multilib"
REQUIRED_USE="multilib? ( || ( 32bit 64bit ) )"

NATIVE_DEPS="media-libs/alsa-lib
	>=media-libs/vst-sdk-2.4
	virtual/opengl"
RDEPEND="!media-plugins/tal-vst
	x86? ( $NATIVE_DEPS )
	amd64? (
		multilib? (
			32bit? ( app-emulation/emul-linux-x86-soundlibs )
			64bit? ( $NATIVE_DEPS )
			)
		!multilib? ( $NATIVE_DEPS ) )"

S="${WORKDIR}/tal-plugins"

pkg_setup() {
	if use x86; then
		export native_install=1
	elif use amd64; then
		# amd64 users can choose only 32-bit VSTs if desired
		if ! use multilib || use 64bit; then
			export native_install=1
		else
			unset native_install
		fi
	fi
}

src_install() {
	if use x86 && [[ $native_install ]]; then
		dodir /usr/lib/vst
		insinto /usr/lib/vst
		cp -R ${S}/32bit/*.so ${D}/usr/lib/vst
	fi

	if use amd64 && [[ $native_install ]]; then
		# install only 64bit plugins
		dodir /usr/$(get_libdir)/vst
		insinto /usr/$(get_libdir)/vst
		cp -R ${S}/64bit/*.so ${D}/usr/$(get_libdir)/vst
	elif
		use amd64 && use 32bit; then
			# install only 32bit plugins
			dodir /usr/lib32/vst
			insinto /usr/lib32/vst
			cp -R ${S}/32bit/*.so ${D}/usr/lib32/vst
	fi

	if	use amd64 && { [[ $native_install ]] && use 32bit; } then
			# install 64bit AND 32bit plugins
			dodir /usr/$(get_libdir)/vst
			insinto /usr/$(get_libdir)/vst
			cp -R ${S}/64bit/*.so ${D}/usr/$(get_libdir)/vst

			dodir /usr/lib32/vst
			insinto /usr/lib32/vst
			cp -R ${S}/32bit/*.so ${D}/usr/lib32/vst
	fi
}
