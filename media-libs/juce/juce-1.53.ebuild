# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils multilib flag-o-matic

MY_P="${P/-/_}"
MY_P="${MY_P/./_}"

DESCRIPTION="C++ class library for developing cross-platform applications, especially UIs for audio and video software"
HOMEPAGE=" http://www.rawmaterialsoftware.com/juce"
SRC_URI="mirror://sourceforge/juce/${MY_P}.zip "
RESTRICT="mirror"

S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug demo +flac jucer +opengl vorbis xinerama"
# jucer is the handy IDE

RDEPEND="media-libs/freetype:2
	media-libs/alsa-lib
	flac? ( media-libs/flac )
	vorbis? ( media-libs/libvorbis )
	x11-libs/libX11
	amd64? ( app-emulation/emul-linux-x86-xlibs )"
DEPEND="${RDEPEND}
	app-arch/unzip
	|| ( ( 	x11-proto/xineramaproto
			x11-proto/xextproto
			x11-proto/xproto ) )
	opengl? ( virtual/opengl )"

src_compile() {
	# demo fails with --as-needed
	filter-ldflags -Wl,--as-needed --as-needed

	local myconf=""
		use debug && myconf="CONFIG=Debug" || myconf="CONFIG=Release"
	if ! use xinerama; then
		sed -i -e "s:  #define JUCE_USE_XINERAMA 1://  #define JUCE_USE_XINERAMA 1:" juce_Config.h
	fi

	if use opengl; then
		sed -i -e "s://  #define JUCE_OPENGL 1:  #define JUCE_OPENGL 1:" juce_Config.h
	fi

	cd "${S}"/Builds/Linux
	# debug
	elog "Running CFLAGS=${CFLAGS} emake ${myconf} ..."
	emake ${myconf} || die "compiling the juce library failed"

	if use demo; then
		cd "${S}/extras/JuceDemo/Builds/Linux"
		emake ${myconf} || die "compiling the juce demo failed"
	fi

	if use jucer; then
		cd "${S}/extras/the jucer/build/linux"
		emake ${myconf} || die "compiling jucer failed"
	fi

	# compile 32bit too on amd64
	if use amd64; then
		elog "Compiling 32bit lib, too..."

		# move 32bit lib out of the way
		mv "${S}/bin/libjuce.a" "${WORKDIR}/lib64juce.a"
		# clean bin dir
		rm -rf "${S}"/bin/*
		# and compile the lib again
		cd "${S}"/Builds/Linux
		emake clean
		# alert for this next part
		elog "Running CFLAGS=${CFLAGS} emake ${myconf} ..."
		CFLAGS="${CFLAGS} -m32"
		emake ${myconf}
	fi
}

src_install() {
	if use amd64; then
		insinto /usr/lib32
		doins bin/libjuce.a
		insinto /usr/lib64
		newins ${WORKDIR}/lib64juce.a libjuce.a
	else
		dolib bin/*.a
	fi
	use demo && dobin "extras/JuceDemo/Builds/Linux/build/jucedemo"
	use jucer && dobin "extras/the jucer/build/linux/build/jucer"
	insinto /usr/share/doc/"${P}"
	doins docs/*.html docs/*.css docs/*.txt
	mv docs/images "${D}"/usr/share/doc/"${P}"
	insinto /usr/include/"${PN}"
	doins *.h
	# remove unneeded sources
	rm -rf src/juce_appframework/audio/audio_file_formats/flac
	rm -rf src/juce_appframework/audio/audio_file_formats/oggvorbis
	rm -rf src/juce_appframework/gui/graphics/imaging/image_file_formats/jpglib
	rm -rf src/juce_appframework/gui/graphics/imaging/image_file_formats/pnglib
	cp -R src "${D}"/usr/include/"${PN}"
	cp -R amalgamation "${D}"/usr/include/"${PN}"
	# don't install .cpp files
	for i in `find ${D}/usr/include/${PN}/src -name *.cpp`; do
		rm -f $i
	done

	# fix paths to VST-SDK2.4, as installed from the overnight overlay
	sed -i -e "s:<public.sdk/source/vst2.x/audioeffectx.h>:<vst24/audioeffectx.h>:g" ${D}/usr/include/juce/src/audio/plugin_client/VST/juce_VST_Wrapper.cpp
	sed -i -e "s:<public.sdk/source/vst2.x/aeffeditor.h>:<vst24/aeffeditor.h>:g" ${D}/usr/include/juce/src/audio/plugin_client/VST/juce_VST_Wrapper.cpp
	sed -i -e "s:<public.sdk/source/vst2.x/audioeffectx.cpp>:<vst24/audioeffectx.cpp>:g" ${D}/usr/include/juce/src/audio/plugin_client/VST/juce_VST_Wrapper.cpp
	sed -i -e "s:<public.sdk/source/vst2.x/audioeffect.cpp>:<vst24/audioeffect.cpp>:g" ${D}/usr/include/juce/src/audio/plugin_client/VST/juce_VST_Wrapper.cpp
}
