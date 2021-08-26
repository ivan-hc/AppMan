# AppMan
AppImage Manager that works like APT or Pacman.

# Disclaimer
This is just a script-based experimental project to be perfected, it is by no means finished.

# What works?
Updating applications and cleaning up any backup files created after each update.
To install applications I wrote a separate `appman-install` script, a `appman-remove` script to remove them and an `appman-sync` script to update both the previous scripts. I usually manage my scripts to create AppImages too using [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit), just like you can do with PKGBUILDs in Arch Linux with the AUR repository, but with the standalone nature of AppImages.
Some examples are already available in other repositories:

[AnyDesk](https://github.com/ivan-hc/AnyDesk-AppImage-installer), the popular remote desktop's client;

[IceSSB](https://github.com/ivan-hc/Ice-SSB-AppImage), a web-app manager from Peppermint OS;

[OcenAudio](https://github.com/ivan-hc/Ocenaudio-Editor-AppImage), an audio editor, the best alternative to Audacity;

[OpenShot QT](https://github.com/ivan-hc/OpenShot-QT-AppImage), a powerfull video editor;

[qBittorrent Stable](https://github.com/ivan-hc/qBittorent-Stable-AppImage), one of the best bittorrent clients.

However, from now I'll take care of creating other scripts [here](https://github.com/ivan-hc/AppMan/tree/main/applications).

# Requirement (important)
- [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) to update AppImages

# Requirements 2 (optional)
The following requirements will come in handy if you want install/remove [applications](https://github.com/ivan-hc/AppMan/tree/main/applications):
- [pkg2appimage](https://github.com/AppImage/pkg2appimage) to compile the *.ylm recipe
- [appimagetool](https://github.com/AppImage/AppImageKit) to convert a *.AppDir folder to AppImage

# Environment setup
I decided to concentrate all the work in a hypothetical /opt/bin folder. If you're using Debian or its derivatives (Ubuntu, Zorin, Mint, SparkyLinux...) you can rely on my [deb packages for x86_64](https://github.com/ivan-hc/AppImage-Tools-for-Debian) and bypass all the following commands.

To create a /bin folder in /opt:

`sudo mkdir /opt/bin`

If you want you can assign the classic permissions to this folder, in order to be able to operate freely with tools such as "appimageupdatetool", so:

`sudo chown $USER /opt/bin`

Now we need to download [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) creating a symlink in /usr/bin for the best workflow in terms of updates:

`cd /opt/bin`

`wget https://github.com/AppImage/AppImageUpdate/releases/download/continuous/appimageupdatetool-x86_64.AppImage`

`mv ./appimageupdatetool-x86_64.AppImage ./appimageupdate`

`chmod a+x ./appimageupdate`

`sudo ln -s /opt/bin/appimageupdate /usr/bin/appimageupdate`

Optionally do the same for [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit):

`wget https://github.com/AppImage/pkg2appimage/releases/download/continuous/pkg2appimage-{VERSION}-x86_64.AppImage`

`wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage`

`mv ./pkg2appimage-{VERSION}-x86_64.AppImage ./pkg2appimage && mv ./appimagetool-x86_64.AppImage ./appimagetool`

`chmod a+x ./appimagetool ./pkg2appimage`

`sudo ln -s /opt/bin/pkg2appimage /usr/bin/pkg2appimage`

`sudo ln -s /opt/bin/appimagetool /usr/bin/appimagetool`

NOTE: also changing the AppImage name by removing the extension is optional, I do it for convenience of use when I write my own scripts to update my programs.

# Environment variable in /opt/bin
Add an environment variable to your bashrc:

`echo "export PATH=$PATH:/opt/bin" >> /home/$USER/.bashrc`

# Script usage - Commands (what is working now)
The scripts I wrote calls other scripts that I placed in /opt/bin, not just for AppImages (as you can see):

`appman [options]`

where options include:

`-h`		          Print this message.

`-u` or `update`	Update all the AppImages in /opt/bin using appimageupdate and asks to remove residual *zs-old backup files.

`-c` or `clean`	  Cleans /opt/bin by removing all *zs-old backup files.

`sdk`		          Updates platform-tools for Android (adb, fastboot...). This is not related to an AppImage.

 Commands:
  
  `appman-install` - Install an application, the whole list is available [here](https://github.com/ivan-hc/AppMan/tree/main/applications).
  
  `appman-remove` - Removes an application, its launcher and icon.
  
  `appman-sync` - Updates [the list of available applications](https://github.com/ivan-hc/AppMan/tree/main/applications).

All the scripts I use on my PC are available in this repository, you're free to modify them and implement new funcionalities for your use case. And why not? To create a new utility to manage AppImages and other software this way.

# Why not AppImaged?
[AppImaged](https://github.com/probonopd/go-appimage) is a great project, I love it as an idea... but its frustrating to have so much superfluous launchers (for example, command-line utilities), I can't rename the AppImage by removing the extension, launchers and wrong icons due to the way the developer he bundled the software are useless and sometime they can't be launched (for example Avidemux), the update daemon has never worked for me and requires an AppImage that doesn't work on my desktop environment... but the hatefull thing is an Applications folder that appears each time I want to remove it, in my home folder, also if all AppImages are stored into a different path.
Practically AppImaged contrasts with my idea of order.
I believe that a centralized repository from which to install software and manage updates is the best choice, and AppImage is a format that deserves more success than Snap and Flatpak.
