# AppMan
AppImage Manager that works like APT or Pacman.

# How it works

AppMan uses some [precompiled scripts](https://github.com/ivan-hc/AppMan/tree/main/applications) that can download applications from their main sites or compiling them using [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit), just like you can do with PKGBUILDs in AUR, the final result is a ready to use AppImage with a launcher and its icon (where needed, command line tools like "wine" can be only used from the terminal) for your favourite application. The complete list is vailable [here](https://github.com/ivan-hc/AppMan/tree/main/applications).

AppMan uses [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) to update AppImages (if zsync support is available), there is also an option to clean all backup files created after each update.

# Requirement
- [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) to update AppImages
- [pkg2appimage](https://github.com/AppImage/pkg2appimage) to compile *.ylm recipes
- [appimagetool](https://github.com/AppImage/AppImageKit) to convert a *.AppDir folder to AppImage

# Environment setup
I decided to concentrate all the work in a hypothetical /opt/bin folder. If you're using Debian or its derivatives (Ubuntu, Zorin, Mint, SparkyLinux...) you can rely on my [deb packages for x86_64](https://github.com/ivan-hc/AppImage-Tools-for-Debian) and bypass all the following commands until the next paragraph.

To create a /bin folder in /opt:

`sudo mkdir /opt/bin`

Assign permissions to $USER for /opt/bin, in order to be able to operate without root privileges with tools such as "appimageupdate", so:

`sudo chown $USER /opt/bin`

Now we need to download [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) creating a symlink in /usr/bin for the best workflow in terms of updates:

`cd /opt/bin`

`wget https://github.com/AppImage/AppImageUpdate/releases/download/continuous/appimageupdatetool-x86_64.AppImage`

`mv ./appimageupdatetool-x86_64.AppImage ./appimageupdate`

`chmod a+x ./appimageupdate`

`sudo ln -s /opt/bin/appimageupdate /usr/bin/appimageupdate`

Do the same for [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit):

`wget https://github.com/AppImage/pkg2appimage/releases/download/continuous/pkg2appimage-{VERSION}-x86_64.AppImage`

`wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage`

`mv ./pkg2appimage-{VERSION}-x86_64.AppImage ./pkg2appimage && mv ./appimagetool-x86_64.AppImage ./appimagetool`

`chmod a+x ./appimagetool ./pkg2appimage`

`sudo ln -s /opt/bin/pkg2appimage /usr/bin/pkg2appimage`

`sudo ln -s /opt/bin/appimagetool /usr/bin/appimagetool`

NOTE: also changing the AppImage name by removing the extension is optional, I do this to write easilly my scripts.

# Environment variable in /opt/bin
Add an environment variable to your bashrc:

`echo "export PATH=$PATH:/opt/bin" >> /home/$USER/.bashrc`

# Installation
Download the following scripts and put them in /opt/bin:

- [appman](https://raw.githubusercontent.com/ivan-hc/AppMan/main/opt/bin/appman), this is a main command;
- [appinstall](https://raw.githubusercontent.com/ivan-hc/AppMan/main/opt/bin/appinstall), needed to install programs from [here](https://github.com/ivan-hc/AppMan/tree/main/applications);
- [appremove](https://raw.githubusercontent.com/ivan-hc/AppMan/main/opt/bin/appremove), needed to remove programs installed through appman-install;

# Script usage - Commands
The script I wrote calls other scripts that I placed in /opt/bin, not just for AppImages (as you can see):

`appman [options]`

where options include:

`-h`		          Print this message.

`-c` or `--clean`	 Cleans /opt/bin by removing all *zs-old backup files.

`-l` or `--list`   Shows the list of available apps in the repository.

`-s` or `--sync`   Updates the [list of available applications](https://github.com/ivan-hc/AppMan/tree/main/applications) in "appman-install" and "appman-remove".

`-u` or `--update`	Update all the AppImages in /opt/bin using appimageupdate.

 Commands:

  `appinstall [PROGRAM]` - Install an application, the whole list is available [here](https://github.com/ivan-hc/AppMan/tree/main/applications).
  
  `appremove [PROGRAM]` - Removes an application, its launcher and icon.
  
  
# Why not AppImaged?
[AppImaged](https://github.com/probonopd/go-appimage) is a great project, I love it as an idea... but its frustrating to have so much superfluous launchers (for example, command-line utilities), I can't rename the AppImage by removing the extension, launchers and wrong icons due to the way the developer he bundled the software are useless and sometime they can't be launched (for example Avidemux), the update daemon has never worked for me and requires an AppImage that doesn't work on my desktop environment... but the hatefull thing is an Applications folder that appears each time I want to remove it, in my home folder, also if all AppImages are stored into a different path.
Practically AppImaged contrasts with my idea of order.
I believe that a centralized repository from which installing software and manage updates is the best choice, and AppImage is a format that deserves more success than Snap and Flatpak. I hope AppMan can be its home.
