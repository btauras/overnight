# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

PYTHON_DEPEND="2"
EAPI=2

inherit python eutils toolchain-funcs

MY_P=${P/csound-/Csound}
DOC_VERSION="5.13"
STK_VERSION="4.4.2"

DESCRIPTION="A sound design, music synthesis and signal processing system"
HOMEPAGE="http://csound.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}5/${PN}${DOC_VERSION}/${MY_P}.tar.gz
doc? ( mirror://sourceforge/${PN}/${PN}5/${PN}${DOC_VERSION}/manual/Csound${DOC_VERSION}_manual_html.zip )
stk? ( http://ccrma.stanford.edu/software/stk/release/stk-${STK_VERSION}.tar.gz )"
# Vst support is currently broken; I'll look into it later
#vst? ( vstsdk2_4_rev1.zip )
#vst-host? ( vstsdk2_4_rev1.zip )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa beats csoundac -doc +double-precision dssi editor examples fluidsynth gui jack java lua mp3 musicxml newparser osc p5glove pd +python stk tcl wiimote"

RDEPEND=">=media-libs/libsndfile-1.0.13
	alsa? ( media-libs/alsa-lib )
	csoundac? ( x11-libs/fltk:1.1[threads]
		dev-libs/boost
		dev-lang/swig )
	dssi? ( media-libs/dssi
		media-libs/ladspa-sdk )
	editor? ( x11-libs/fltk:1.1[threads] )
	fluidsynth? ( media-sound/fluidsynth )
	gui? ( x11-libs/fltk:1.1[threads] )
	jack? ( media-sound/jack-audio-connection-kit )
	java? ( || ( virtual/jre virtual/jdk ) )
	lua? ( dev-lang/lua )
	mp3? ( media-sound/mpadec )
	musicxml? ( media-libs/libmusicxml:2 )
	osc? ( media-libs/liblo )
	p5glove? ( media-libs/libp5glove )
	stk? ( =media-libs/stk-${STK_VERSION} )
	tcl? ( >=dev-lang/tcl-8.5
		>=dev-lang/tk-8.5 )
	wiimote? ( media-libs/wiiuse )"
# 	pd? ( virtual/pd )

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/scons
	app-arch/unzip"

S="${WORKDIR}/${MY_P}"
RESTRICT="mirror"

pkg_setup() {
	python_set_active_version 2

#	if use pd; then
#		ewarn "You have enabled pd (PureData) use-flag."
#		ewarn "Please abort the build with CTRL-C, and install"
#		ewarn "\"pd-overlay\" with layman ...unless you have done"
#		ewarn "it already."
#		ewarn
#		epause 5
#	fi

#	if use vst; then
#		if ! use csoundac || ! use gui; then
#			eerror "Please set USE=\"csoundac gui\" with vst use-flag!"
#			die
#		fi
#	fi
}

src_prepare() {
	epatch ${FILESDIR}/install-stk-cvs.patch
	epatch ${FILESDIR}/javaVM-cvs.patch
	epatch ${FILESDIR}/libmusicxml-cvs.patch
	if use double-precision; then
		epatch ${FILESDIR}/use-double.patch
	fi

	if use stk; then
		ebegin "Copying Perry Cook's Synthesis ToolKit to the tree"
		cp -r ${WORKDIR}/stk-${STK_VERSION}/* ${S}/Opcodes/stk/
		eend
	fi

#	if use vst || use vst-host; then
#		ebegin "Copying Steinberg's VST SDK to the tree"
#		cp -r ${WORKDIR}/vstsdk2.4 ${S}/frontends/CsoundVST/
#		eend
#	fi
}

src_compile() {
	local sconsconf="prefix=/usr \
		buildRelease=1 \
		pythonVersion=$(python_get_version) \
		dynamicCsoundLibrary=1 \
		tclversion=8.5 \
		usePortAudio=0 \
		usePortMIDI=0 \
		useCoreAudio=0 \
		buildUtilities=1 \
		buildInterfaces=1"
	if use amd64; then
		sconsconf="${sconsconf} Word64=1 Lib64=1"
	fi
	! use alsa; sconsconf="${sconsconf} useALSA=$?"
	! use beats; sconsconf="${sconsconf} buildBeats=$?"
	! use csoundac; sconsconf="${sconsconf} buildCsoundAC=$?"
	# Totally broken
	#! use doc; sconsconf="${sconsconf} generatePdf=$?"
	! use double-precision; sconsconf="${sconsconf} useDouble=$?"
	! use dssi; sconsconf="${sconsconf} buildDSSI=$?"
	! use editor; sconsconf="${sconsconf} useFLTK=$? buildCSEditor=$?"
	! use gui; sconsconf="${sconsconf} useFLTK=$? buildCsound5GUI=$? buildVirtual=$?"
	! use jack; sconsconf="${sconsconf} useJack=$?"
	! use java; sconsconf="${sconsconf} buildJavaWrapper=$?"
	# Handled by the media-libs/loris package
	#! use loris; sconsconf="${sconsconf} buildLoris=$?"
	! use lua; sconsconf="${sconsconf} buildLuaWrapper=$?"
	! use mp3; sconsconf="${sconsconf} includeMP3=$?"
	! use newparser; sconsconf="${sconsconf} buildNewParser=$?"
	! use osc; sconsconf="${sconsconf} useOSC=$?"
	! use p5glove; sconsconf="${sconsconf} includeP5Glove=$?"
	#! use pd; sconsconf="${sconsconf} buildPDClass=$?"
	! use python; sconsconf="${sconsconf} buildPythonOpcodes=$? buildPythonWrapper=$?"
	! use stk; sconsconf="${sconsconf} buildStkOpcodes=$?"
	! use tcl; sconsconf="${sconsconf} buildTclcsound=$?"
	#! use vst; sconsconf="${sconsconf} buildCsoundVST=$?"
	#! use vst-host; sconsconf="${sconsconf} buildvst4cs=$?"
	! use wiimote; sconsconf="${sconsconf} includeWii=$?"

	einfo "Building Csound with the following configuration options:"
	einfo ${sconsconf}
	epause 3

	# Sandbox violations
	addpredict "/usr/include"
	addpredict "/usr/lib"
	addpredict "/etc/ld.so.cache"

	scons CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		customCCFLAGS="$CFLAGS -fno-strict-aliasing" \
		customCXXFLAGS="$CXXFLAGS -fno-strict-aliasing" \
		${sconsconf} || die "Scons failed!"
}

src_install() {
	if use amd64; then
		./install.py --prefix="/usr" --instdir="${D}" --word64
	else
		./install.py --prefix="/usr" --instdir="${D}"
	fi
	# Post-installation fixes (probably should patch install.py instead, but...)
	rm -rf ${D}/usr/*.md5sums
	rm -rf ${D}/usr/share/doc/csound
	rm -rf ${D}/usr/bin/uninstall-csound5

	if use csoundac; then
		insinto $(python_get_sitedir)
		doins CsoundAC.py
		insopts -m0755
		doins _CsoundAC.so
		if use lua; then
			insinto /usr/$(get_libdir)/csound/lua
			doins luaCsoundAC.so
		fi
		insopts -m0644
	fi
	if use lua; then
		insinto /usr/$(get_libdir)/csound/lua
		insopts -m0755
		doins luaCsnd.so
		insopts -m0644
	fi

	if use double-precision; then
		echo "OPCODEDIR64=/usr/$(get_libdir)/csound/plugins64" > 61csound5
	else
		echo "OPCODEDIR=/usr/$(get_libdir)/csound/plugins" > 61csound5
	fi
	echo "CSSTRNGS=/usr/share/locale" >> 61csound5
	doenvd 61csound5

	dodoc AUTHORS ChangeLog
	newdoc Loadable_Opcodes.txt Loadable_Opcodes
	newdoc readme-csound5.txt README.Csound5
	newdoc readme-csound5-complete.txt README.Csound5-VST
	if use doc; then
		dohtml -r ${WORKDIR}/html/*
	fi
	if use examples; then
		insinto /usr/share/doc/${PR}
		doins -r examples
	fi
}

pkg_postinst() {
	elog "If you are interested in 'Loris Opcodes for Csound',"
	elog "please install media-libs/loris with USE=\"csound\"."
}
