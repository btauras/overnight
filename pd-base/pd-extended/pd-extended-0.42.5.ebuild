# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools eutils flag-o-matic versionator

DESCRIPTION="Realtime multimedia environment and additional plugins"
HOMEPAGE="http://www.puredata.org/"
SRC_URI="http://sourceforge.net/projects/pure-data/files/${PN}/${PV}/Pd-${PV}-extended.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

Linux="+hid +pdp +pidip +gem2pdp +iem16 +pdp_opengl +postlude"
# oscx is deprecated by the mrpeach external
externals="-oscx +zexy +iem_matrix"
IUSE_PD_EXTERNALS="+adaptive +bassemu +boids +bsaylor +creb +cxc +cyclone
	+earplug +ekext +ext13 +flashserver +flatspace +flib +freeverb +ggee
	+hcs +iem_ambi +iem_bin_ambi +iemlib +iemgui +iem_adaptfilt +iemmatrix
	 +iemxmlrpc +iem_delay +iem_roomsim +iem_spec2 +iem_tab
	jasch_lib +loaders +mapping +markex +maxlib +mjlib +moocow
	+moonlib +motex +mrpeach +pan +pdcontainer +pddp +pdogg +pmpd
	+sigpack +smlib +tof +toxy unauthorized +vanilla +vbap +windowing"
IUSE="+alsa debug fftw +jack portaudio
	${IUSE_PD_EXTERNALS} ${Linux} ${externals}"

DEPEND="dev-lang/tcl
	dev-lang/tk
	media-libs/flac
	media-sound/lame
	media-libs/ladspa-sdk
	media-libs/libsndfile
	alsa? ( media-libs/alsa-lib )
	fftw? ( sci-libs/fftw )
	hcs? ( dev-libs/libusb )
	jack? ( media-sound/jack-audio-connection-kit )
	pdogg? ( media-libs/libogg 
		media-libs/libvorbis )
	portaudio? ( media-libs/portaudio )
	unauthorized? ( media-libs/speex
		media-sound/lame )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Pd-${PV}-extended/"

src_prepare() {
	cd "${S}/pd/src"
	eautoreconf
}

src_configure() {
	cd "${S}/pd/src"
	econf \
		$(use_enable alsa) \
		$(use_enable jack) \
		$(use_enable debug) \
		$(use_enable fftw) \
		$(use_enable portaudio)
}

src_compile() {
	cd "${S}/pd/src"
	emake

	# build externals in $IUSE
	cd "${S}/externals"
	for external_useflag in ${IUSE_PD_EXTERNALS}; do
		local external=${external_useflag#[+-]}
		if use ${external}; then
			elog "Building external '${external}'"
			local my_make_opts=""
			case ${external} in
			oscx|unauthorized|zexy)
				# fails to build with parallel make
				my_make_opts="${my_make_opts} -j1"
				;;
			esac
			emake OPT_CFLAGS="${CFLAGS} -fPIC -DPIC" DESTDIR="${D}" prefix="/usr" \
				${my_make_opts} ${external} || die "${external} failed"
		fi
	done
}

src_install() {
	# install pd-extended
	cd "${S}/pd/src"
	emake DESTDIR="${D}" prefix="/usr" install

	# install private headers for developers
	insinto /usr/include
	doins m_pd.h m_imp.h g_canvas.h t_tk.h s_stuff.h g_all_guis.h

	# install externals
	cd "${S}/externals"
	for external_useflag in ${IUSE_PD_EXTERNALS}; do
		local external=${external_useflag#[+-]}
		if use ${external}; then
			elog "Installing external '${external}'"
			emake DESTDIR="${D}" prefix=/usr ${external}_install || \
				die "install '${external}' failed"
		fi
	done

	newicon ${S}/packages/linux_make/pd.png pd-extended.png
	domenu ${FILESDIR}/${PN}.desktop
}
