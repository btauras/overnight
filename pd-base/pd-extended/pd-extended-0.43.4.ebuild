# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit autotools eutils flag-o-matic versionator

DESCRIPTION="Realtime multimedia environment and additional plugins"
HOMEPAGE="http://www.puredata.info"
SRC_URI="http://sourceforge.net/projects/pure-data/files/${PN}/${PV}/Pd-extended_${PV}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

Linux="+hid +pdp +gem2pdp +iem16"
# oscx is deprecated by the mrpeach external
externals="-oscx +zexy"
IUSE_PD_EXTERNALS="apple arraysize +bassemu +boids +bsaylor chaos +creb +cxc
	+earplug +ekext +ext13 +flatgui +freeverb +ggee grh
	+hcs +iemlib jasch_lib +loaders-hexloader +loaders-libdir +loaders-tclpd
	+loaders-pdlua log +mapping +markex +maxlib miXed
	+mjlib +moocow +moonlib +motex +mrpeach +pan +pdcontainer +pddp +pdogg
	pduino +plugin +pmpd +sigpack +smlib testtools +tof unauthorized +vanilla
	+vbap +windowinga"
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
	loaders-pdlua? ( dev-lang/lua )
	pdogg? ( media-libs/libogg 
		media-libs/libvorbis )
	portaudio? ( media-libs/portaudio )
	unauthorized? ( media-libs/speex
		media-sound/lame )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}/pd/"

src_prepare() {
	#cd "${WORKDIR}/${PN}/externals/loaders/pdlua"
	#epatch "${FILESDIR}/Makefile.patch"
	cd "${S}/pd/"
	#cd "${S}"
	eautoreconf
}

src_configure() {
	cd "${S}/pd/src"
	#cd "${S}/src"
	econf \
		$(use_enable alsa) \
		$(use_enable jack) \
		$(use_enable debug) \
		$(use_enable fftw) \
		$(use_enable portaudio)
}

src_compile() {
	cd "${S}/src"
	#cd "${S}/pd/src"
	emake

	# build externals in $IUSE
	cd "${WORKDIR}/${PN}/externals"
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
	#cd "${S}/pd/src"
	cd "${S}/src"
	emake DESTDIR="${D}" prefix="/usr" install || die "initial install failed"
	
	cd "${S}/src"
	# install private headers for developers
	insinto /usr/include/pdextended || die "can't insinto"
	doheader m_pd.h m_imp.h g_canvas.h s_stuff.h g_all_guis.h || die "no doheader"

	# install externals
	cd "../../externals"
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
