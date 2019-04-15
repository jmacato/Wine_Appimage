#!/bin/bash
# Pre install
dpkg --add-architecture i386
apt update
apt install -y aptitude wget file bzip2

# Get Wine
wget -nv -c https://dl.winehq.org/wine-builds/debian/dists/buster/main/binary-i386/wine-devel_4.6~buster_i386.deb
wget -nv -c https://dl.winehq.org/wine-builds/debian/dists/buster/main/binary-i386/wine-devel-i386_4.6~buster_i386.deb

dpkg -x wine-devel_4.6~buster_i386.deb wineversion/
dpkg -x wine-devel-i386_4.6~buster_i386.deb wineversion/

cp -r "wineversion/opt/"* "wineversion"
rm -r "wineversion/opt"
rm -rf "wineversion/usr"

wineworkdir=(wineversion/*)
cd $wineworkdir

# Add a dependency library, such as freetype font library
wget -nv -c https://github.com/Hackerl/Wine_Appimage/releases/download/v0.9/libhookexecv.so -O bin/libhookexecv.so
wget -nv -c https://github.com/Hackerl/Wine_Appimage/releases/download/v0.9/wine-preloader_hook -O bin/wine-preloader_hook

chmod +x bin/wine-preloader_hook

pkgcachedir='/tmp/.winedeploycache'
mkdir -p $pkgcachedir

aptitude -y -d -o dir::cache::archives="$pkgcachedir" install libwine:i386 libva2:i386 libva-drm2:i386 libva-x11-2:i386 libvulkan1:i386

find $pkgcachedir -name '*deb' ! -name 'libwine*' -exec dpkg -x {} . \;

rm -rf $pkgcachedir

# appimage
cd -

wget -nv -c "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage" -O  appimagetool.AppImage
chmod +x appimagetool.AppImage

chmod +x AppRun

cp AppRun $wineworkdir
cp resource/* $wineworkdir

./appimagetool.AppImage --appimage-extract

export ARCH=x86_64; squashfs-root/AppRun -v $wineworkdir -u 'gh-releases-zsync|mmtrt|Wine_Appimage|continuous|Wine-x86_64.AppImage.zsync'