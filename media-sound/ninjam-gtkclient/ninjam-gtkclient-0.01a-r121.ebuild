# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

export WANT_AUTOCONF="2.5"
inherit eutils toolchain-funcs

DESCRIPTION="Make music with people via the internet, gtk client"
HOMEPAGE="http://www.ninjam.com/"
#SRC_URI="https://gninjam.svn.sourceforge.net/svnroot/gninjam/libninjam/trunk"
# gtk client source, should already be patched to build:
SRC_URI="https://launchpad.net/~kxstudio-team/+archive/ppa/+files/gninjam_0.01a%2Bsvn121-1ubuntu0%7Elucid1.tar.gz"
# needs gtkmm, gconfmm, gettext, pkg-config, WANT_AUTOCONF=:2.5, 

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/gninjam-0.01a+svn121"

DEPEND="dev-cpp/gconfmm
	dev-cpp/gtkmm
	media-libs/alsa-lib
	media-libs/libogg
	media-libs/libvorbis
	media-sound/jack-audio-connection-kit
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

#src_prepare() {
#	epatch "${FILESDIR}"/makefile.patch
#}

src_compile() {
	tc-export CC CXX
	OPTFLAGS="${CXXFLAGS}" emake
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS
}
### TODO: remove all the QA warnings ###

#* QA Notice: Pre-stripped files found:
#* /usr/bin/ninjamsrv
#* /usr/bin/cninjam
#* /usr/lib/libninjam-common.so
#* /usr/lib/libninjam-client.so
#strip: x86_64-pc-linux-gnu-strip --strip-unneeded -R .comment
#	usr/lib/libninjam-common.a
#	usr/lib/libninjam-client.a
# x86_64-pc-linux-gnu-strip:/var/tmp/portage/media-sound/ninjam-cclient-0.01a/image/usr/lib/libninjam-client.a(libninjam-common.a): Unable to recognise the format of file: File format not recognized

#* QA Notice: The following shared libraries lack a SONAME
#* /usr/lib/libninjam-client.so
#* /usr/lib/libninjam-common.so
#removing executable bit: usr/lib/libninjam-client.a
#removing executable bit: usr/lib/libninjam-common.a
