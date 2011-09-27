# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils flag-o-matic git-2 toolchain-funcs
## need to make it build on both arches before we need this eclass:
#multilib

DESCRIPTION="VST port of mlr, using JUCE"
HOMEPAGE="https://github.com/hemmer/mlrVST"
EGIT_REPO_URI="git://github.com/hemmer/mlrVST"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="${DEPEND}"
DEPEND="
	media-libs/alsa-lib
	media-libs/freetype:2
	media-libs/juce
	media-libs/oscpack
	>=media-libs/vst-sdk-2.4
	virtual/opengl
	x11-libs/libXinerama"

S="${WORKDIR}/${PN}"

src_prepare() {
	cd Builds/Linux
	#epatch "${FILESDIR}"/makefile.patch
	sed -i -e 's:../../oscpack:/usr/include/oscpack:g' \
		-e 's:win32/:posix/:g' \
		-e 's:~/SDKs/vstsdk2.4:/usr/include/vst24:g' \
		-e 's:../../../../../src:/usr/include/juce/src:g' \
		Makefile
		## fixed upstream 9-21
		#-e 's/CPPFLAGS := $(DEPFLAGS)/CPPFLAGS := $(DEPFLAGS) -D "OSC_HOST_LITTLE_ENDIAN"/g' \

	# fix pathes to use system JUCE
	cd ../../
	sed -i -e 's:../../../../juce_amalgamated.h:/usr/include/juce/juce_amalgamated.h:g' \
		JuceLibraryCode/JuceHeader.h

	## fix private function call - fixed upstream 9-21
	#sed -i -e 's:audioReader = 0:audioReader:g' Source/AudioSample.cpp

	# amalgamation path fixes to use system JUCE
	sed -i -e 's:../../../../amalgamation:/usr/include/juce/amalgamation:g' \
		JuceLibraryCode/JuceLibraryCode1.cpp
	sed -i -e 's:../../../../amalgamation:/usr/include/juce/amalgamation:g' \
		JuceLibraryCode/JuceLibraryCode2.cpp
	sed -i -e 's:../../../../amalgamation:/usr/include/juce/amalgamation:g' \
		JuceLibraryCode/JuceLibraryCode3.cpp
	sed -i -e 's:../../../../amalgamation:/usr/include/juce/amalgamation:g' \
		JuceLibraryCode/JuceLibraryCode4.cpp
}

src_compile() {
	cd Builds/Linux

	if
		use debug; then
		emake CXX="$(tc-getCXX)" CONFIG=Debug
	else
		replace-flags -Os -O3
		emake CXX="$(tc-getCXX)" CONFIG=Release
	fi
}

### TODO: build 64bit and 32bit plugins on multilib systems
#src_install() {
#	if use amd64 && use 32bit; then
#		dodir /usr/lib32/vst
#		insinto /usr/lib32/vst
#		dolib.so ${S}/linux/*.so ${D}/usr/lib32/vst/ ;
#	elif use amd64 ; then
#		dodir /usr/$(get_libdir)/vst
#		insinto /usr/$(get_libdir)/vst ;
#	fi
#}

src_install() {
	insinto /usr/$(get_libdir)/vst
	doins Builds/Linux/build/mlrVST.so ${D}/usr/$(get_libdir)/vst/
}

### TODO
# 1. figure out building 64bit and 32-bit plugins on multilib systems
# 2. work with upstream mlrVST and JUCE to get JACK and JACK transport supported
#    so that multichannel out and MIDI devices will work.
#    - note that mlrVST's code is very shaky here, as normally JUCE can't do
#      multichannel outputs as a runtime option. mlrVST needs to talk to
#      JUCE properly, not using outside system calls. right now it doesn't
#      handle audio callbacks very nicely.
# 3. get file drag'n'drop working: https://github.com/hemmer/mlrVST/issues/4
# 4. figure out why GUI won't load the first several times in renoise
# 5. add standalone alternative using DISTRHO's patches to mlrVST and JUCE.
#    - the nice thing is it no longer depends on VST-SDK!
#    - however, the standalone mlrVST needs additional code for JACK transport
#      so that it can detect BPM from JACK/JACK-apps
#      - look into the JUCED fork for ideas, as well as JUCE upstream forum
# 6. push the sed commands in this ebuild into a real patch
