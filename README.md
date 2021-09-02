# AppMan
AppImage Manager that works like APT or Pacman ([video](https://www.youtube.com/watch?v=H4XTYBV__1s)).

# How it works
AppMan uses some [precompiled scripts](https://github.com/ivan-hc/AppMan/tree/main/applications) that can download applications from their main sites or compiling them using [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit), just like you can do with PKGBUILDs in AUR, the final result is a ready to use AppImage with a launcher and its icon (where needed, command line tools like "wine" can be only used from the terminal) for your favourite application. The complete list is available [here](https://github.com/ivan-hc/AppMan/tree/main/applications).

AppMan uses [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) to update AppImages (if zsync support is available), there is also an option to clean all backup files created after each update.

# Requirement
AppMan works with:
- [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) to update AppImages
- [pkg2appimage](https://github.com/AppImage/pkg2appimage) to compile *.ylm recipes
- [appimagetool](https://github.com/AppImage/AppImageKit) to convert a *.AppDir folder to AppImage

You don't need to download them, each AppImage is included in the installation script. Keep reading!

# Installation
The installer requires privileges to create an /opt/bin directory and three symlinks for each [appimage tool needed](https://github.com/ivan-hc/AppMan/tree/main/appimage-tools) directly in /usr/bin to work. Learn more by read the [INSTALL](https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL) script.

Download and run the INSTALL script:

`wget https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL`

`chmod a+x ./INSTALL`

`sudo ./INSTALL`

`sudo chown -R $USER /opt/bin/`

Now add this line at the end of your /home/$USER/.bashrc :

`export PATH=$PATH:/opt/bin`

Download the application's list (no "SUDO" privileges are needed):

`appman -s` or `appman sync`


# AppMan usage - Commands
`appman [option]`  or `appman [option] [argument]`
 
 where option include:
 
  `-h`, `help`	Print this message.

  `-a [argument]`, `about [argument]` Show basic info on each application, link to the website and/or the source and how to update some applications.

  `-c`, `clean`	Remove all unnecessary files and folders, i.e. backup	files, installation scripts, and temporary folders.
  
  `-f`, `files`	Programs installed on the system.
  
  `-i [argument]`, `install [argument]` 	Install a program.
  
  `-l`, `list`	Shows the list of apps available in the repository.
  
  `-r [argument]`, `remove [argument]`	Removes a program.
  
  `-s`, `sync`	Updates the list of available apps.
  
  `-u`, `update`	Update AppImages using 'appimageupdate', if the update info is embedded into the AppImage itself by the developer.
  

# Uninstall
`sudo rm /opt/bin/appman /opt/bin/appimagetool /opt/bin/appimageupdate /opt/bin/pkg2appimage /usr/bin/appimagetool /usr/bin/appimageupdate /usr/bin/pkg2appimage`


# Why not AppImaged?
[AppImaged](https://github.com/probonopd/go-appimage) is a great project, I love it as an idea... but its frustrating to have so much superfluous launchers (for example, command-line utilities), I can't rename the AppImage by removing the extension, launchers and wrong icons due to the way the developer have bundled the software are useless and sometime they can't be launched (for example Avidemux), the update daemon has never worked for me and requires an AppImage that doesn't work on my desktop environment... but the hatefull thing is an Applications folder that appears each time I want to remove it, in my home folder, also if all AppImages are stored into a different path.

Practically AppImaged contrasts with my idea of order.

I believe that a centralized repository from which installing software and manage updates is the best choice, and AppImage is a format that deserves more success than Snap and Flatpak. I hope AppMan can be the home of AppImages and other standalone programs for GNU/Linux, and always provide all distributions with the latest software version in the same way.


# How to add applications
On AppMan I try to add programs that can be updated as much as possible to the latest version. However, whether the application is updatable or not, a link to the official website will appear at the end of the installation or by running the `appman -a [program]` command, so that you can always be updated on the latest news of your applications favorite.

The [sheets I use to compile the programs on my computer are entirely in bash](https://github.com/ivan-hc/AppMan/tree/main/models), and are compiled specifically to speed up uploading of the programs in the list, according to the method in which they can be ready for use (for [pkg2appimage recipes](https://github.com/ivan-hc/AppMan/main/models/PKG2APPIMAGE-installer), [DEB packages](https://github.com/ivan-hc/AppMan/main/models/LOCALDEB-installer), [Arch Linux packages](https://github.com/ivan-hc/AppMan/main/models/LOCALARCH-installer) or [AppImages](https://github.com/ivan-hc/AppMan/main/models/WGETSIMPLE-installer)).

Given these patterns, you can easily test their actual functioning yourself. Any pull request is welcome, I will do my best to make it possible.


# About me
This is my first work as a developer and I hope this will not be the last.

Having encouraged you to visit this page is already an immense achievement for me.

If you wish, you can help me [with a small donation](https://paypal.me/ivanalexhc). I will gladly appreciate it!
