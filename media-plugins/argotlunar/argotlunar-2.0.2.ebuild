# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit eutils multilib qt4-r2

DESCRIPTION="Realtime granulator VST plugin"
HOMEPAGE="http://argotlunar.info/"
SRC_URI="http://argotlunar.info/argotlunar-2.0.2-src.7z"
#SRC_URI="http://argotlunar.info/${P}-src.zip"
#SRC_URI="http://github.com/nightmorph/"
# we use a customized version that has been patched to include a buildsystem
# (premake) and that compiles against the latest JUCE, 1.53. patching by falktx
# orig: http://kxstudio.sourceforge.net/tmp/argotlunar-2.0.2-linux.7z
# create patch?

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="0"
#IUSE="+dynamic"
IUSE=""

RDEPEND="${DEPEND}"
# upstream 2.0.2 pkg only builds against juce-1.52
# it also comes with no makefiles because the
# CodeBlocks IDE doesn't provide them, which is what upstream uses
# see the special tarball (soon to be patchset) which fixes this
# needs premake to build
DEPEND="<dev-util/premake-4
	media-libs/alsa-lib
	media-libs/freetype:2
	media-libs/juce
	>=media-libs/vst-sdk-2.4
	virtual/opengl"

S="${WORKDIR}/${P}-src"

#steps:
#should be a qtcreate file, use QtCreator and .. qmake && make
#make 32bit
#make 64bit
#copy .so files to /usr/lib/vst
#(will need renaming to a proper *.so file name after build)
#look in premake.lua for any manual changes to dirs

src_prepare() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:../vstsdk2.4:/usr/include/vst24:g" linux/premake.lua

	sed -i -e "s:<public.sdk/source/vst2.x/audioeffectx.h>:<vst24/audioeffectx.h>:g" wrapper/VST/juce_VST_Wrapper.cpp
	sed -i -e "s:<public.sdk/source/vst2.x/aeffeditor.h>:<vst24/aeffeditor.h>:g" wrapper/VST/juce_VST_Wrapper.cpp
	sed -i -e "s:<public.sdk/source/vst2.x/audioeffectx.cpp>:<vst24/audioeffectx.cpp>:g" wrapper/VST/juce_VST_Wrapper.cpp
	sed -i -e "s:<public.sdk/source/vst2.x/audioeffect.cpp>:<vst24/audioeffect.cpp>:g" wrapper/VST/juce_VST_Wrapper.cpp

#	use dynamic && \
#		sed -i -e 's:package.linkflags = { "static-runtime" }::g' linux/premake.lua
#		sed -i -e 's:-static::g' linux/premake.lua
		#sed -i -e 's:"rt",:"rt", "juce", :g' linux/premake.lua
#		sed -i -e 's:#include "juce_amalgamated.cpp"::g'	JuceLibraryCode/JuceLibraryCode.cpp
#		rm JuceLibraryCode/juce_amalgamated.cpp
}

src_compile() {
	cd linux
	emake
}

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
	doins ${S}/linux/libargotlunar.so ${D}/usr/$(get_libdir)/vst/
}
