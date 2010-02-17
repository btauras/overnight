# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit autotools eutils subversion

DESCRIPTION="Songbird is a desktop Web player, a digital jukebox and Web browser mash-up."
HOMEPAGE="http://www.songbirdnest.com/"
ESVN_REPO_URI="http://publicsvn.songbirdnest.com/client/trunk/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="aac +alsa debug esd ffmpeg flac gnome +jpeg +mp3 musepack +ogg oss speex theora ugly"

# No need to specify gst-plugins-base, as the individual gst RDEPs pull it in
# Same for the minimum required gstreamer version
RDEPEND="
	dev-db/sqlite:3
	dev-libs/dbus-glib
	>=dev-libs/nspr-4.7.1
	>=dev-libs/nss-3.12
	media-plugins/gst-plugins-mpeg2dec
	media-plugins/gst-plugins-neon
	media-plugins/gst-plugins-x
	media-plugins/gst-plugins-xvideo
	net-libs/xulrunner:1.9
	sys-apps/hal
	aac? ( media-plugins/gst-plugins-faac
	media-plugins/gst-plugins-faad )
	alsa? ( media-plugins/gst-plugins-alsa )
	esd? ( media-plugins/gst-plugins-esd )
	ffmpeg? ( media-plugins/gst-plugins-ffmpeg )
	flac? ( media-plugins/gst-plugins-flac )
	gnome? ( media-plugins/gst-plugins-gconf
		media-plugins/gst-plugins-gnomevfs )
	jpeg? ( media-plugins/gst-plugins-jpeg )
	mp3? ( media-plugins/gst-plugins-lame
		media-plugins/gst-plugins-mad )
	musepack? ( media-plugins/gst-plugins-musepack )
	ogg? ( media-plugins/gst-plugins-ogg
		media-plugins/gst-plugins-vorbis )
	oss? ( media-plugins/gst-plugins-oss )
	speex? ( media-plugins/gst-plugins-speex )
	theora? ( media-plugins/gst-plugins-theora )
	ugly? ( media-libs/gst-plugins-ugly )"
DEPEND="dev-libs/liboil
	dev-util/pkgconfig
	sys-devel/gettext
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/pango"
# Use cairo[X] and pango[X] once portage 2.2 final is out,
# as these are EAPI-2 functions
# Then you can get rid of the nasty built_with_use hacks

##try without this block first
#DEPEND="x11-libs/libXdmcp
#	x11-libs/libXau
#	x11-libs/libXfixes
#	x11-libs/libXcursor
#	x11-libs/libXrandr
#	x11-libs/libXi
#	x11-libs/libXrender
#	x11-libs/libXext
#	x11-libs/libX11
#	dev-libs/liboil
#	x11-libs/gtk+:2
#	virtual/xft
#	x11-libs/pango"

#S="${WORKDIR}/Songbird"
#RESTRICT="strip"

#src_install() {
#	insinto /opt/songbird
#	doins -r *
#	fperms 755 /opt/songbird/songbird
#	fperms 755 /opt/songbird/songbird-bin
#	fperms 755 /opt/songbird/xulrunner/xulrunner
#	fperms 755 /opt/songbird/xulrunner/xulrunner-bin
#	dosym /opt/songbird/songbird /opt/bin/songbird-bin
#
#	newicon ${S}/chrome/icons/default/default.xpm ${PN}.xpm
#	make_desktop_entry /opt/songbird/songbird Songbird ${PN}.xpm /opt/songbird "AudioVideo;Player"
#}

pkg_setup() {
	if ! built_with_use x11-libs/cairo X; then
		eerror "Cairo is not built with X useflag."
		eerror "Please add 'X' to your USE flags, and re-emerge cairo."
		die "Cairo needs X"
	fi

	if ! built_with_use --missing true x11-libs/pango X; then
		eerror "Pango is not built with X useflag."
		eerror "Please add 'X' to your USE flags, and re-emerge pango."
		die "Pango needs X"
	fi
}

src_unpack() {
	subversion_src_unpack
	sed -i -e 's/cd\ ..\///g' ${S}/allmakefiles.sh || die "sed failed"
	eautoreconf
}


src_compile() {
	econf \
		$(use_enable aac) \
		$(use_enable alsa) \
		$(use_enable debug) \
		$(use_enable esd) \
		$(use_enable ffmpeg) \
		$(use_enable flac) \
		$(use_enable gnome) \
		$(use_enable jpeg) \
		$(use_enable mp3) \
		$(use_enable musepack) \
		$(use_enable ogg) \
		$(use_enable oss) \
		$(use_enable speex) \
		$(use_enable theora) \
		$(use_enable ugly) \
		--with-media-core=gstreamer-system \
		|| die "Configure failed!"

	emake || die "emake failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
