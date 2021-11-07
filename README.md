# AppMan
Application Manager for AppImages and other standalone programs. 

- [About AppMan](#about-appman)
- [About AppImages](#about-appimages)
- [How it works](#how-it-works)
- [Installation methods](#installation-methods): [slow (recommended)](#slow-installation-recommended) or [quick](#quick-installation)
- [AppMan usage - Commands](#appman-usage---commands)
- [How to update programs](#how-to-update-programs)
- [What programs can be installed with AppMan](#what-programs-can-be-installed-with-appman)
- [Uninstall](#uninstall)
- [How to add applications](https://github.com/ivan-hc/AppMan#how-to-add-applications)
- [Structure of a submitted app](#structure-of-a-submitted-app)

## About AppMan
AppMan is an application manager for AppImages and other standalone programs that works like APT or Pacman.

The main goal of this tool is to provide the same updated applications to multiple GNU/Linux distributions without having to change the package manager or the distro itself. This means that whatever distro you use, you will not miss your favorite programs or the need for a more updated version. AppMan also aims to be a merger for GNU / Linux distributions, using not just AppImage as the main package format, but also other standalone programs, so without having to risk breaking anything on your system: no daemons, no shared libraries. Just your program and your launcher.

## About AppImages
[AppImage](https://appimage.org/) is a standalone package format, the best choice if you are looking for an alternative packaging format to use on multiple GNU/Linux distributions, it uses fewer resources than Snap and Flatpak, and works completely autonomously, using its own libraries. AppMan aims to give it a home to stay.

## How it works
AppMan uses [precompiled scripts](https://github.com/ivan-hc/AppMan/tree/main/applications) that can download applications from their main sites or compiling them using [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit), just like you can do with PKGBUILDs in AUR. The final result is a ready to use AppImage with a launcher and its icon (where needed, command line tools like "wine" can be only used from the terminal) for your favourite application. The complete list is available [here](https://raw.githubusercontent.com/ivan-hc/AppMan/main/appman-list).

NOTE: programs installed using `pkg2appimage` (for example, all the KDE games) may take several minutes to complete the process and to be ready for use.

AppMan uses [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) to update AppImages (if zsync support is available), there is also an option to clean all backup files created after each update.

A video on a first build is available [here](https://www.youtube.com/watch?v=H4XTYBV__1s) (in reality the features have increased since its release, keep reading).

The [AppMan's installer](https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL) includes [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) (needed to update AppImages), [pkg2appimage](https://github.com/AppImage/pkg2appimage) (to compile *.yml recipes) and [appimagetool](https://github.com/AppImage/AppImageKit) (to convert a *.AppDir folder to AppImage). Nothing else. Other tools are already pre-installed on your system (wget, mv, mkdir...).

# Installation methods

### Slow installation (recommended)

1) Copy/paste this command:

 `wget https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL && chmod a+x ./INSTALL && sudo ./INSTALL`
 
 this will download and run the [INSTALL](https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL) script that will create a directory /opt/bin where "appman" will be downloaded together with "appimagetool", "appimageupdate" and "pkg2appimage", for the latter three symlinks will also be created in /usr/bin. Alternatively (and only if yours is a Debian based system) it is also possible to install the [deb package](https://github.com/ivan-hc/AppMan/releases/latest).

2) Add this line at the end of your /home/$USER/.bashrc :

`export PATH=$PATH:/opt/bin`

3) Change privileges on /opt/bin to use AppMan as normal user:

`sudo chown -R $USER /opt/bin/`

### Quick installation
Copy paste this command:
 
`wget https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL && chmod a+x ./INSTALL && sudo ./INSTALL && echo "export PATH=$PATH:/opt/bin" >> /home/$USER/.bashrc && sudo chown -R $USER /opt/bin/`

this will add a long line to the ~/.bashrc. It is recommended that you log out to make it work.

# AppMan usage - Commands

`appman [option]`  or `appman [option] [argument]`
 
 where option include:
 
  `-h`, `help`	Print this message.

  `-a [argument]`, `about [argument]` Show basic info on each application, link to the website and/or the source and how to update some applications.

  `-c`, `clean`	Remove all unnecessary files and folders, i.e. backup	files, installation scripts, and temporary folders.
  
  `-d [argument]`, `debug [argument]`  Allows you to check for errors and malfunctions when	starting the program or during its entire execution.
  
  `-f`, `files`	Programs installed on the system.
  
  `-i [argument]`, `install [argument]` 	Install a program.
  
  `-l`, `list`	Shows the list of apps available in the repository.
  
  `-q [keywords]`, `query [keywords]` Use one or more keywords to search for in AppMan's list	of available applications.
  
  `-r [argument]`, `remove [argument]`	Removes a program (requires confirmation, default is N).
  
  `-s`, `sync`	Updates the list of available apps.
  
  `-t [argument]`, `template [argument]` Generate a template folder for your application in your /home/$USER directory, so you can manipulate it to your liking and test it on your computer.
  
  `-u`, `update`	Update AppImages using 'appimageupdate', if the update info is embedded into the AppImage itself by the developer.
  
  `-U`, `full-upgrade` Update everything, this will also re-install the non-updatable programs by replacing them with the	latest version available. This may take several minutes, depending on the number of programs, the sizes, the way	they are built, and the download speed. The updatable AppImages will perform the normal update (see "-u", "update").


## How to update programs

There are two kind of updates in AppMan:
- `appman -u` uses [appimageupdate](https://github.com/AppImage/AppImageUpdate) to update those programs with inbuild instructions (so not all);
- `appman -i [argument]` ie the reinstallation of the program, also the launcher will be replaced.

In the first case will be created a *zs-old backup file as big as the original in /opt/bin that you can remove with `appman -c`, in the second case the original file will be replaced directly.

NOTE: since the AppMan 1.5 release you can update everything using the command `appman -U` or `appman full-upgrade`


## What programs can be installed with AppMan

With AppMan you can install three types of programs:

 1. AppImages that can be downloaded directly from the developer's website or repository. They are a direct responsibility of the latter, so please contact it through the link you can view with the command `appman -a <program>` or at the end of the installation, for any problems and bug reports. Many of these programs are listed on [appimage.github.io](https://appimage.github.io/). A small part of these AppImages supports Delta updates with `appimageupdate` (Celestia, WINE, Firefox...);
 2. AppImages which must be compiled with `pkg2appimage` and/or packaged with `appimagetool` (process which can take several minutes to be complete). They have all been tested on Debian Testing/Unstable and may not work on older distributions. These are AppImages created and tested directly by me, the author of AppMan, for example the various web browsers and the KDE game suite;
 3. Some standalone programs NOT packaged as AppImages (Google Chrome, Android Platform-tools, NodeJS/NPM...).
 
All these programs can be updated by reinstalling them individually (`appman -i <program>`) or in bulk (`appman -U`).


## Uninstall
To remove AppMan and all its related dependencies and symlinks, copy/paste this command:

 `sudo rm /opt/bin/appman /opt/bin/appimagetool /opt/bin/appimageupdate /opt/bin/pkg2appimage /usr/bin/appimagetool /usr/bin/appimageupdate /usr/bin/pkg2appimage`


## How to add applications
Download a template from [here](https://github.com/ivan-hc/AppMan/tree/main/models), or just create it with the command:

 `appman -t <your-application>`

all you need to do is to replace the UPPERCASE words (SAMPLE, LINK, LAUNCHER...). Given these patterns, you can easily test them on your PC (command `appman -c` to remove any /tmp folder from /opt/bin). Each template is dedicated to a different way to distribute or create an application, for example:
 - If you have an AppImage hosted somewhere, click [here](https://github.com/ivan-hc/AppMan/tree/main/models/Have%20you%20got%20an%20AppImage%20hosted%20somewhere%3F).
 - If you have a pkg2appimage yml recipe, click [here](https://github.com/ivan-hc/AppMan/tree/main/models/Have%20you%20got%20a%20pkg2appimage%20yml%20recipe%3F).
 - If you have a DEB package, click [here](https://github.com/ivan-hc/AppMan/tree/main/models/Have%20you%20got%20a%20DEB%20package%3F).
 - If you have a .tar.* archive (for Arch Linux or Slackware), click [here](https://github.com/ivan-hc/AppMan/tree/main/models/Have%20you%20got%20an%20Arch%20Linux%20package%3F).

Any pull request is welcome, click [here](https://github.com/ivan-hc/AppMan/pulls) to submit your app.


## Structure of a submitted app
The structure of an application looks like this:

                           $APPNAME (folder)
           ____________________|______________________
          |                    |                      |
    $APPNAME.svg       $APPNAME-installer        about-$APPNAME

- "$APPNAME" is the folder, it contains a script $APPNAME-installer (see above), a $APPNAME.svg icon, an about-$APPNAME info file. $APPNAME must be the same for the folder ($APPNAME), the script ($APPNAME-installer), the icon ($APPNAME.svg) and the info (about-$APPNAME);
- "$APPNAME-installer" is a script, using [my models](https://github.com/ivan-hc/AppMan/tree/main/models) replace APP=SAMPLE with APP=$APPNAME, pay attention to each line you wrote. Replace the word "LAUNCHER" with the content of the original .desktop file of the application, the only thing you must replace is the path of the is the line "Exec", ie "Exec=$APPNAME", it must be "Exec=/opt/bin/$APPNAME" or the app cannot be launched from the main menu (NOTE, launcher is optional if the program is only usable from the command line);
- "$APPNAME.svg" is the icon, only in SVG format, with the same name of $APPNAME (NOTE, like the launcher, icon is optional if the program is only usable from the command line);
- "$about-APPNAME" is a simple text file, it must containt basic info of the app, ie a brief description, update kind (`appman -u` or `appman -i $APPNAME`) and one or two links to the official site and/or the source (take [this](https://raw.githubusercontent.com/ivan-hc/AppMan/main/models/Have%20you%20got%20an%20AppImage%20hosted%20somewhere%3F/SAMPLE/about-SAMPLE) as a model).


## About me
Having encouraged you to visit this page is already a huge achievement for me, being this my really first creation on GitHub, and I also hope this will not my last. If you wish, you can support me, this work and my passion with a small [donation](https://paypal.me/ivanalexhc), I will gladly appreciate it.
