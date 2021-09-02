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
To remove AppMan and all its related dependencies and symlinks, copy/paste this command:

`sudo rm /opt/bin/appman /opt/bin/appimagetool /opt/bin/appimageupdate /opt/bin/pkg2appimage /usr/bin/appimagetool /usr/bin/appimageupdate /usr/bin/pkg2appimage`


# Difference between AppMan and AppImaged (AppImage Daemon)
The main reason that prompted me to create AppMan is the order and precision that was lacking in other standalone application managers and in particular AppImage packages, which are often poorly packaged by their developers and for which there are update management tools and for the integration of the related launchers and icons that fail in their intent.

[Appimaged](https://github.com/probonopd/go-appimage) is a great project, I love it as an idea... but in creating launchers and icons for the menu he relies on what he finds in the root directory of AppDir: sometimes the developer creates his AppImage by inserting an empty *.desktop (launcher) file in AppDir, and also a generic icon and inconsistent with what we would expect. The result is a completely unusable icon in the menu (for example, the official AppImage version of Avidemux). Also, as a *.desktop file and an icon in the main directory of AppDir are required, Appimaged also inserts in the application's menu programs that can only be used from the command line (for example wine, or the same pkg2appimage and appimagetool).

Appimaged only detects programs with the .AppImage extension placed in a folders of its choice. And even if you want to use the AppImage in [a different directory by choosing from the available alternatives made possible by the project](https://github.com/probonopd/go-appimage/blob/master/src/appimaged/README.md#notes), Appimaged will continue to automatically create an "Applications" folder in the user's home, even if you delete it and do not want to use it, it will always appear. As an user, I think this is frustrating.

Finally the updates: for me they never worked except with AppimageUpdate. But I'm probably doing something wrong.

Practically AppImaged contrasts with my idea of order. I believe that a centralized repository from which installing software and manage updates is the best choice for each system: installing/removing/updating programs, cleaning up obsolete files, creating launchers with icons using the original files and getting basic information from each installed application, one by one in order into a specific folder, without extension like a normal executable binary file. I'm not talking about APT or Pacman. AppImages and other standalone programs managed by AppMan are totally independent from the other programs, they just need a system on wich be used.

But also, [AppImage](https://appimage.org/) is also a standalone package format, the best choice if you are looking for an alternative packaging format to use on multiple GNU/Linux distributions, and as such it deserves a home, like Snap and Flatpak.


# How to add applications
On AppMan I try to add programs that can be updated as much as possible to the latest version. However, whether the application is updatable or not, a link to the official website will appear at the end of the installation or by running the `appman -a [program]` command, so that you can always be updated on the latest news of your applications favorite.

The [sheets I use to compile the programs on my computer are entirely in bash](https://github.com/ivan-hc/AppMan/tree/main/models), and are compiled specifically to speed up uploading of the programs in the list, according to the method in which they can be ready for use (for [pkg2appimage recipes](https://github.com/ivan-hc/AppMan/main/models/PKG2APPIMAGE-installer), [DEB packages](https://github.com/ivan-hc/AppMan/main/models/LOCALDEB-installer), [Arch Linux packages](https://github.com/ivan-hc/AppMan/main/models/LOCALARCH-installer) or [AppImages](https://github.com/ivan-hc/AppMan/main/models/WGETSIMPLE-installer)).

Given these patterns, you can easily test their actual functioning yourself. Any pull request is welcome, I will do my best to make it possible.


# About me
This is my first work as a developer and I hope this will not be the last.

Having encouraged you to visit this page is already an immense achievement for me.

If you wish, you can help me [with a small donation](https://paypal.me/ivanalexhc). I will gladly appreciate it!
