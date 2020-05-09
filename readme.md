# Appimage For Wine

## Instructions for lol-patched Appimage

* Download wine-staging lol patched appimage from here

* Mark appimage as exec
`chmod +x wine-staging-i386_lol-patched_x86_64-bionic.AppImage`

* Launch exe file with wine command from appimage
`./wine-staging-i386_lol-patched_x86_64-bionic.AppImage wine xyz.exe`

* Launch winecfg from appimage
`./wine-staging-i386_lol-patched_x86_64-bionic.AppImage wine winecfg`

## Launching preinstalled league from snap data
* Launching wine-staging appimage wine command from download directory as example
`./wine-staging-i386_lol-patched_x86_64-bionic.AppImage wine "../snap/leagueoflegends/common/.wine/drive_c/Riot Games/League of Legends/LeagueClient.exe"`

## Note
* Default wineprefix is set to
`.wine-appimage-lol`

* If you are using preinstalled league make sure you install `directx9` otherwise you face font issue

* use `appimageupdate` appimage to update wine appimage with smaller delta update. 
 `https://github.com/AppImage/AppImageUpdate/releases/download/continuous/AppImageUpdate-x86_64.AppImage`