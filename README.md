# AppMan
AppImage Manager that works like APT or Pacman.

The main goal of this tool is to provide the same updated applications to multiple GNU/Linux distributions without having to change the package manager or the distro itself. This means that whatever distro you use, you will not miss your favorite programs or the need for a more updated version. AppMan also aims to be a merger for GNU / Linux distributions, using not just AppImage as the main package format, but also other standalone programs, so without having to risk breaking anything on your system: no daemons, no shared libraries. Just your program and your launcher.

[AppImage](https://appimage.org/) is a standalone package format, the best choice if you are looking for an alternative packaging format to use on multiple GNU/Linux distributions, it uses fewer resources than Snap and Flatpak, and works completely autonomously, using its own libraries. AppMan aims to give it a home to stay.

# How it works
AppMan uses [precompiled scripts](https://github.com/ivan-hc/AppMan/tree/main/applications) that can download applications from their main sites or compiling them using [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit), just like you can do with PKGBUILDs in AUR. The final result is a ready to use AppImage with a launcher and its icon (where needed, command line tools like "wine" can be only used from the terminal) for your favourite application. The complete list is available [here](https://raw.githubusercontent.com/ivan-hc/AppMan/main/appman-list).

AppMan uses [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) to update AppImages (if zsync support is available), there is also an option to clean all backup files created after each update.

A video on a first build is available [here](https://www.youtube.com/watch?v=H4XTYBV__1s) (in reality the features have increased since its release, keep reading).

The [AppMan's installer](https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL) includes [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) (needed to update AppImages), [pkg2appimage](https://github.com/AppImage/pkg2appimage) (to compile *.yml recipes) and [appimagetool](https://github.com/AppImage/AppImageKit) (to convert a *.AppDir folder to AppImage). Nothing else. Other tools are already pre-installed on your system (wget, mv, mkdir...).


# Installation

1) Download and run the [INSTALL](https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL) script, this will create a directory /opt/bin where "appman" will be downloaded together with "appimagetool", "appimageupdate" and "pkg2appimage", for the latter three symlinks will also be created in /usr/bin:

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
  
  `-d [argument]`, `debug [argument]`  Allows you to check for errors and malfunctions when	starting the program or during its entire execution.
  
  `-f`, `files`	Programs installed on the system.
  
  `-i [argument]`, `install [argument]` 	Install a program.
  
  `-l`, `list`	Shows the list of apps available in the repository.
  
  `-q [keywords]`, `query [keywords]` Use one or more keywords to search for in AppMan's list	of available applications.
  
  `-r [argument]`, `remove [argument]`	Removes a program (requires confirmation, default is N).
  
  `-s`, `sync`	Updates the list of available apps.
  
  `-u`, `update`	Update AppImages using 'appimageupdate', if the update info is embedded into the AppImage itself by the developer.


# How to update programs

There are two kind of updates in AppMan:
- `appman -u` uses [appimageupdate](https://github.com/AppImage/AppImageUpdate) to update those programs with inbuild instructions (so not all);
- `appman -i [argument]` ie the reinstallation of the program, also the launcher will be replaced.

In the first case will be created a *zs-old backup file as big as the original in /opt/bin that you can remove with `appman -c`, in the second case the original file will be replaced directly.


# Uninstall
To remove AppMan and all its related dependencies and symlinks, copy/paste this command:

`sudo rm /opt/bin/appman /opt/bin/appimagetool /opt/bin/appimageupdate /opt/bin/pkg2appimage /usr/bin/appimagetool /usr/bin/appimageupdate /usr/bin/pkg2appimage`


# How to add applications
AppMan aims to give updated programs to every distribution with all the basic info on each application (command `appman -a [program]`).

By downloading [sheets I provided](https://github.com/ivan-hc/AppMan/tree/main/models), all you need to do is to replace the UPPERCASE words (SAMPLE, LINK, LAUNCHER...). The sheets are needed to speed up uploading of the programs in the list. The main "flavours are for:
- Recipe that requires... [pkg2appimage recipes](https://github.com/ivan-hc/AppMan/blob/main/models/PKG2APPIMAGE-installer);
- Recipe that requires downloading and unpacking of [DEB packages](https://github.com/ivan-hc/AppMan/blob/main/models/LOCALDEB-installer);
- Recipe that requires downloading and unpacking of [Arch Linux packages](https://github.com/ivan-hc/AppMan/blob/main/models/LOCALARCH-installer);
- [AppImages](https://github.com/ivan-hc/AppMan/blob/main/models/WGETSIMPLE-installer).

Given these patterns, you can easily test them on your PC (command `appman -c` to remove any /tmp folder from /opt/bin).

[Any pull request is welcome](https://github.com/ivan-hc/AppMan/pulls), I will do my best to make it possible.


# How to prepare an application - structure
Considering your applications is called $APPNAME, the structure looks like this:

                           $APPNAME (folder)
           ____________________|______________________
          |                    |                      |
    $APPNAME.svg       $APPNAME-installer        about-$APPNAME

- "$APPNAME" is the folder, it contains a script $APPNAME-installer (see above), a $APPNAME.svg icon, an about-$APPNAME info file. $APPNAME must be the same for the folder ($APPNAME), the script ($APPNAME-installer), the icon ($APPNAME.svg) and the info (about-$APPNAME);
- "$APPNAME-installer" is a script, using [my models](https://github.com/ivan-hc/AppMan/tree/main/models) replace APP=SAMPLE with APP=$APPNAME, pay attention to each line you wrote. Replace the word "LAUNCHER" with the content of the original .desktop file of the application, the only thing you must replace is the path of the is the line "Exec", ie "Exec=$APPNAME", it must be "Exec=/opt/bin/$APPNAME" or the app cannot be launched from the main menu (NOTE, launcher is optional if the program is only usable from the command line);
- "$APPNAME.svg" is the icon, only in SVG format, with the same name of $APPNAME (NOTE, like the launcher, icon is optional if the program is only usable from the command line);
- "$about-APPNAME" is a simple text file, it must containt basic info of the app, ie a brief description, update kind (`appman -u` or `appman -i $APPNAME`) and one or two links to the official site and/or the source (take [this one](https://raw.githubusercontent.com/ivan-hc/AppMan/main/applications/firefox/about-firefox) as a model).


# About me
This is my really first creation on GitHub, I also hope this will not my last. I have a lot of passion for GNU / Linux and actually too much time to spend for something.

Having encouraged you to visit this page is already a huge achievement for me.

If you wish, you can help me [with a small donation](https://paypal.me/ivanalexhc). I will gladly appreciate it!
