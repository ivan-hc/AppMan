# AppMan
AppImage Manager that works like APT or Pacman.

# How it works
AppMan uses [precompiled scripts](https://github.com/ivan-hc/AppMan/tree/main/applications) that can download applications from their main sites or compiling them using [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit), just like you can do with PKGBUILDs in AUR, the final result is a ready to use AppImage with a launcher and its icon (where needed, command line tools like "wine" can be only used from the terminal) for your favourite application. The complete list is available [here](https://github.com/ivan-hc/AppMan/tree/main/applications).

AppMan uses [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) to update AppImages (if zsync support is available), there is also an option to clean all backup files created after each update.

# Requirement
AppMan's installer includes the following AppImages:
- [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) to update AppImages;
- [pkg2appimage](https://github.com/AppImage/pkg2appimage) to compile *.yml recipes;
- [appimagetool](https://github.com/AppImage/AppImageKit) to convert a *.AppDir folder to AppImage.

# Installation
The [installer](https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL) requires root privileges to create an /opt/bin directory, three symlinks [for each appimage tool needed](https://github.com/ivan-hc/AppMan/tree/main/appimage-tools) directly in /usr/bin and `chown` to change permissions on /opt/bin:

1) Download and run the [INSTALL](https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL) script, this will create an /opt/bin directory, three symlinks [for each appimage tool needed](https://github.com/ivan-hc/AppMan/tree/main/appimage-tools) directly in /usr/bin:

`wget https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL`

`chmod a+x ./INSTALL`

`sudo ./INSTALL`

2) Change privileges on /opt/bin to use AppMan as normal user:

`sudo chown -R $USER /opt/bin/`

3) Add this line at the end of your /home/$USER/.bashrc :

`export PATH=$PATH:/opt/bin`

4) Download the application's list:

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
  
  `-r [argument]`, `remove [argument]`	Removes a program (requires confirmation, default is N).
  
  `-s`, `sync`	Updates the list of available apps.
  
  `-u`, `update`	Update AppImages using 'appimageupdate', if the update info is embedded into the AppImage itself by the developer.
  
# Uninstall
To remove AppMan and all its related dependencies and symlinks, copy/paste this command:

`sudo rm /opt/bin/appman /opt/bin/appimagetool /opt/bin/appimageupdate /opt/bin/pkg2appimage /usr/bin/appimagetool /usr/bin/appimageupdate /usr/bin/pkg2appimage`

# Difference between AppMan and AppImaged (AppImage Daemon)
The main reason that prompted me to create AppMan is the order and precision that was lacking in other standalone application managers for AppImage packages, often poorly packaged by their developers, so creating launchers and icons is a disaster.

[Appimaged](https://github.com/probonopd/go-appimage), for example, is a great project born from a great idea... but in creating launchers and icons for the menu it relies on what it finds in the AppDir main directory. Infact sometimes the developer creates his AppImage by inserting an empty *.desktop  file (launcher) in AppDir along a generic icon, both required in the packaging process, but inconsistent with what we would expect. The result is a completely unusable icon in the menu. And this is not limited to the graphical programs, Appimaged also creates launchers for command line tools.

Appimaged only detects programs with the .AppImage extension placed in folders of its choice. If you choose [a different path](https://github.com/probonopd/go-appimage/blob/master/src/appimaged/README.md#notes), Appimaged will continue to automatically create a non hidden "Applications" folder in the user's home, even if you delete it (and this is frustrating).

Finally the updates: for me they never worked (except with AppimageUpdate), but maybe I'm doing something wrong.

Practically AppImaged contrasts with my idea of "order".

That's why I believe that a centralized repository from which installing software and manage updates is the best choice for each system: installing/removing/updating programs, cleaning up obsolete files, creating launchers with icons using the original files and getting basic info from each application by typing a command, with all the programs in one place and without extension for a faster typing, like a normal executable binary file. This seems to be the description of the mainstream package managers APT or Pacman, but I'm don't talking about them. AppImages and other standalone programs managed by AppMan are totally independent from each other, what they need is just a system on which to run.

[AppImage](https://appimage.org/) is a standalone package format, the best choice if you are looking for an alternative packaging format to use on multiple GNU/Linux distributions, it uses fewer resources than Snap and Flatpak, and works completely autonomously, using its own libraries. AppMan aims to give it a home to stay.

# How to add applications
AppMan aims to give updated programs to every distribution with all the basic info on each application (command `appman -a [program]`).

By downloading [sheets I provided](https://github.com/ivan-hc/AppMan/tree/main/models), all you need to do is to replace the UPPERCASE words (SAMPLE, LINK, LAUNCHER...). The sheets are needed to speed up uploading of the programs in the list. The main "flavours are for:
- [pkg2appimage recipes](https://github.com/ivan-hc/AppMan/main/models/PKG2APPIMAGE-installer);
- [DEB packages](https://github.com/ivan-hc/AppMan/main/models/LOCALDEB-installer);
- [Arch Linux packages](https://github.com/ivan-hc/AppMan/main/models/LOCALARCH-installer);
- [AppImages](https://github.com/ivan-hc/AppMan/main/models/WGETSIMPLE-installer)).

Given these patterns, you can easily test them on your PC (command `appman -c` to remove any /tmp folder from /opt/bin).
Any pull request is welcome, I will do my best to make it possible.

# About me
This is my really first creation on GitHub, I also hope this will not my last. I have a lot of passion for GNU / Linux and actually too much time to spend for something.

Having encouraged you to visit this page is already a huge achievement for me.

If you wish, you can help me [with a small donation](https://paypal.me/ivanalexhc). I will gladly appreciate it!
