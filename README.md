# AppMan
AppImage Manager that works like APT or Pacman.

# Disclaimer
This is just a script-based experimental project to be perfected, it is by no means finished.

# Requirements (important)
- [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) to update AppImages

# Requirements 2 (optional)
- [pkg2appimage](https://github.com/AppImage/pkg2appimage) to compile the *.ylm recipe
- [appimagetool](https://github.com/AppImage/AppImageKit) to convert a *.AppDir folder to AppImage

# Environment setup
I decided to concentrate all the work in a hypothetical / opt / bin folder, so:

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
The script I wrote calls other scripts that I placed in /opt/bin, not just for AppImages (as you can see):

`appman [options]`

where options include:

`-h`		          Print this message.

`-u` or `update`	Update all the AppImages in /opt/bin using appimageupdate and asks to remove residual *zs-old backup files.

`-c` or `clean`	  Cleans /opt/bin by removing all *zs-old backup files.

`sdk`		          Updates platform-tools for Android (adb, fastboot...). This is not relatet do an AppImage.

All the scripts I use are available in this repository, you're free to modify them and implement new funcionalities for your use case. And why not? To create a new utility to manage AppImages and other software this way. TAKE THEM JUST AS AN EXAMPLE!

# The future - things to do (commands and functionalities)
I want to manage my scripts to create AppImages using [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit), just like you can do with PKGBUILDs in Arch Linux with the AUR repository, but with the indemendency of AppImages, maybe creating a script that installs the AppImage, creates a .desktop file and the icon, maybe the options `-i` or `install` command, or a `-s` or `sync` option to download a list of software available. Also a `-r` or `remove` option to delete the AppImage, the launcher and the icon. I hope to succeed as soon as possible.

# Why not AppImaged?
[AppImaged](https://github.com/probonopd/go-appimage) is a great project, I love it as an idea... but its frustrating to have so much superfluous launchers (for example, command-line utilities), I can't rename the AppImage by removing the extension, launchers and wrong icons due to the way the developer he bundled the software are useless and sometime they can't be launched (for example Avidemux), the update daemon has never worked for me and requires an AppImage that doesn't work on my desktop environment... but the hatefull thing is an Applications folder that appears each time I want to remove it, in my home folder, also if all AppImages are stored into a different path.
Practically AppImaged contrasts with my idea of order.
I believe that a centralized repository from which to install software and manage updates is the best choice, and AppImage is a format that deserves more success than Snap and Flatpak.
