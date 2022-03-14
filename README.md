# AppMan: install applications locally and without root privileges
Application Manager for AppImages and other standalone programs.

[About AppMan](#about-appman)
- [About AppImages](#about-appimages)
- [How it works](#how-it-works)

[Installation](#installation)
- [Usage](#usage)
- [What programs can be installed with AppMan](#what-programs-can-be-installed-with-appman)
- [Updates](#updates)
- [Repository and Multiarchitecture](#repository-and-multiarchitecture)
- [How to add applications](https://github.com/ivan-hc/AppMan#how-to-add-applications)
- [Known issues](#known-issues)

[Uninstall](#uninstall)

[About "AM" Application Manager](#about-am-application-manager)

[Conclusions](#conclusions)

-----------------------------------------------------------------------------


## About AppMan
AppMan is an application manager for AppImages and other standalone programs that works like APT or Pacman.

The main goal of this tool is to provide the same updated applications to multiple GNU/Linux distributions without having to change the package manager or the distro itself. This means that whatever distro you use, you will not miss your favorite programs or the need for a more updated version. AppMan also aims to be a merger for GNU / Linux distributions, using not just AppImage as the main package format, but also other standalone programs, so without having to risk breaking anything on your system: no daemons, no shared libraries. Just your program and your launcher.

## About AppImages
[AppImage](https://appimage.org/) is a standalone package format, the best choice if you are looking for an alternative packaging format to use on multiple GNU/Linux distributions, it uses fewer resources than Snap and Flatpak, and works completely autonomously, using its own libraries. AppMan aims to give it a home to stay.

## How it works
Since the 2.0 release, AppMan took over the base code from its own successor, ["AM" Application Manager](https://github.com/ivan-hc/AM-Application-Manager) and takes all sources from the "AM" repository itself.

If before AppMan had its own archive of scripts and icons to install programs (click [here](https://github.com/ivan-hc/AppMan/archive/refs/tags/1.8.zip) to download the old 1.8 version's source code), the project was interrupted for several months while I myself was busy working on a new application manager that could integrate all the programs with the system, allowing multiple users of the same PC to use the same applications from multiple different accounts.
That code base also served to improve AppMan, which has a new life since March 2022.

All AppMan does is to convert [all the installation scripts for "AM"](https://github.com/ivan-hc/AM-Application-Manager/tree/main/programs) (that normally must be executed with ROOT privileges) in normal scripts that can manage applications in the local folder of the current user. This allows more users to be able to better configure their account.

To learn more about "AM" and all its scripts, visit the official repository at https://github.com/ivan-hc/AM-Application-Manager

# Installation

Copy/paste this command:

 `wget https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL && chmod a+x ./INSTALL && sudo ./INSTALL`
 
 this command will download and run the [INSTALL](https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL) script that:
 - creates a directory /opt/appman where "appman" will be downloaded and a "remove" script needed to remove "appman" itself;
 - creates a symlink /usr/local/bin/appman;
 - adds the line `export PATH=$PATH:$(xdg-user-dir USER)/.local/bin` to your ~/.bashrc file (requires confirmation, else the installation will be aborted).

NOTE: once the new line will be added the only way to remove it is to edit the ~/.bashrc file manually.

You can install AppMan also from "AM" itself:

    sudo am -i appman
And vice versa, you can install "AM" from AppMan:

    sudo appman -i am
NOTE: "AM" is the only program managed by "AppMan" that requires root privileges to be installed.

## Usage
Being AppMan based on "AM" 2.6.1-2, it uses [the same commands of that amazing release](https://github.com/ivan-hc/AM-Application-Manager/blob/main/README.md#usage).

  ALL THE OPTIONS:
    
  `-a`, `about`
  
  USAGE: "`appman -a $PROGRAM`"
  
  DESCRIPTION: Shows the basic information, links and source of each app.
  
-----------------------------------------------------------------------------
  `-b`, `backup`
  
  USAGE: "`appman -b $PROGRAM`"
  
  DESCRIPTION: Save the current version of a program you are interested in, the snapshot will be stored in /home/$USER/.am-snapshots/$PROGRAM (see "-o"). 
  
-----------------------------------------------------------------------------
  `-c`, `clean`
  
  USAGE: "`appman -c`"
  
  DESCRIPTION: Removes all the unnecessary files and temporary folders.
  
-----------------------------------------------------------------------------
  `-d`, `download`
  
  USAGE: "`appman -d $PROGRAM`"
  
  DESCRIPTION: Download an installation script from the "AM" repository to your desktop without installing it. This option can download scripts from both "programs" (stable scripts on the repository) and "testing" (where scripts are unstable and not complete at all), for your architecture.
  
-----------------------------------------------------------------------------
  `-f`, `files`
  
  USAGE: "`appman -f`"
  
  DESCRIPTION: Shows the installed programs managed by "AppMan".
  
-----------------------------------------------------------------------------
  `-h`, `help`
  
  USAGE: "`appman -h`"
  
  DESCRIPTION: Prints this message. 
  
-----------------------------------------------------------------------------
  `-i`, `install`
  
  USAGE: "`appman -i $PROGRAM`"
  
  DESCRIPTION: Install a program. This will be downloader/created into a dedicated ~/.opt/$PROGRAM directory (containing a script to remove it and another one to update it), the command is linked to ~/.local/bin and a launcher AM-$PROGRAM.desktop will be created in ~/.local/share/applications.
  
-----------------------------------------------------------------------------
  `-l`, `list`
  USAGE: "`appman -l`"
  DESCRIPTION: Shows the list of apps available in the repository.

-----------------------------------------------------------------------------
  `-o`, `overwrite`
  USAGE: "`appman -o $PROGRAM`"
  DESCRIPTION: Overwrite the existing version of the program with a saved snapshot from /home/$USER/.am-snapshots/$PROGRAM (see "-b").
  
-----------------------------------------------------------------------------  
  `-q`, `query`
  
  USAGE: "`appman -q $KEYWORD`"
  
  DESCRIPTION: Use one or more keywords to search for in the list of available applications.
  
-----------------------------------------------------------------------------		
  `-r`, `remove`
  
  USAGE: "`appman -r $PROGRAM`"
  
  DESCRIPTION: Removes the program and all the other files listed above using the instructions in ~/.opt/$PROGRAM/remove. Confirmation is required (Y or N, default is Y).
  
-----------------------------------------------------------------------------
  `-s`, `sync`
  
  USAGE: "`appman -s`"
  
  DESCRIPTION: Updates "AppMan" to a more recent version.
  
-----------------------------------------------------------------------------  		
  `-t`, `template`
  
  USAGE: "`appman -t $PROGRAM`"
  
  DESCRIPTION: This option allows you to generate a custom script for "AM" Application Manager from a list of different templates that may be vary according to the kind of $PROGRAM you want to create/install/update. Once you choose a number, the script will download the template by renaming it using the argument "$PROGRAM" you provided above. Please, consider submitting your custom script to "AM" Application Manager, at https://github.com/ivan-hc/AM-application-manager/pulls.

-----------------------------------------------------------------------------
  `-u`, `update`
  
  USAGE: "`appman -u`"
  
  DESCRIPTION: Update all the installed programs.
  
  `-u`, `update`
  
  USAGE: "`appman -u $PROGRAM`"
  
  DESCRIPTION: Update the selected program, this also allows you to see all the logs during the installation process.
  
-----------------------------------------------------------------------------
  `-v`, `--version`, `version`
  
  USAGE: "`appman -v`"
  
  DESCRIPTION: Shows the version of "appman".
  
-----------------------------------------------------------------------------
  `-w`, `web`
  
  USAGE: "`appman -w $PROGRAM`"
  
  DESCRIPTION: Shows the URLs of the sites/sources of $PROGRAM.
-----------------------------------------------------------------------------
  `--disable-completion`
  
  USAGE: "`sudo appman --disable-completion`"
  
  DESCRIPTION: Removes the /etc/bash_completion.d/appman-completion.sh script previously created with the "appman --enable-completion" command.
  
-----------------------------------------------------------------------------
  `--enable-completion`
  
  USAGE: "`sudo appman --enable-completion`"
  
  DESCRIPTION: Create a bash completion script in /etc/bash_completion.d to complete a keyword with the TAB key using the names of all installable applications in the "AM" repository.
  
-----------------------------------------------------------------------------
  `lock`
  
  USAGE: "`appman lock $PROGRAM`"
  
  DESCRIPTION: Lock the selected $PROGRAM to the current installed version, this only works if a dedicated "AM-updater" script exists.
  
-----------------------------------------------------------------------------
  `unlock`
  
  USAGE: "`appman unlock $PROGRAM`"
  
  DESCRIPTION: Unlock updates for the selected $PROGRAM. This option nulls "lock", the update file is renamed as "AM-updater" again, so that it can be intercepted when executing the "appman -u" command (see "-u").
  
-----------------------------------------------------------------------------

## What programs can be installed with AppMan

Being based on "AM", AppMan installs/removes/updates/manages locally only standalone programs, ie those programs that can be run from a single directory in which they are contained (where `$PROGRAM` is the name of the application, AM installs them always into a dedicated folder named `/opt/$PROGRAM`).

These programs are taken:
- from official sources (see Firefox, Thunderbird, Blender, NodeJS, Chromium Latest...);
- from official .deb packages (see Brave, Vivaldi, Google Chrome...);
- from the repositories and official sites of individual developers (if an archive is not available, an official AppImage is used, see Libreoffice, OnlyOffice);
- from tar archives of other GNU/Linux distributions (see Chromium, Chromium Ungoogled...);
- from AUR or other Arch Linux-related sources (see Palemoon, Spotify, WhatsApp...);
- from AppImage recipes to be compiled with [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit) (see Anydesk, qBittorrent, Dropbox, all the games from the "KDE Games" suite...);
- from unofficial repositories of developers external to the project concerned (most of the time they are programs in AppImage format), but only if an official release is not available (see the various WINE, Zoom, VLC, GIMP...).

You can consult basic information, links to sites and sources used through the related `appman -a $PROGRAM` command or by clicking on [this link on the "AM" repository](https://github.com/ivan-hc/AM-application-manager/tree/main/programs/.about) to see the "readme" of each script.

## Updates
To update all the programs, just run the command:

    appman -u
To update just one program (and to read the output from the shell):

    appman -u $PROGRAM
Here are the ways in which the updates will be made:
- Updateable AppImages can rely on an [appimageupdatetool](https://github.com/AppImage/AppImageUpdate)-based "updater" or on their external zsync file (if provided by the developer);
- Non-updateable AppImages and other standalone programs will be replaced only with a more recent version if available, this will be taken by comparing the installed version with the one available on the source (using "curl", "grep" and "cat"), the same is for some AppImages created with [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit);
- Fixed versions will be listed with their build number (e.g. $PROGRAM-1.1.1). Note that most of the programs are updateable, so fixed versions will only be added upon request (or if it is really difficult to find a right wget/curl command to download the latest version).

In "AM" during the first installation, the main user ($currentuser) will take the necessary permissions on each /opt/$PROGRAM directory, in this way all updates will be automatic and without root permissions. The applications installed using "AM" are available for all the users of the system, while with AppMan they are available only locally. In both cases you're able to manage the content of the application's directory without root privileges.
			
## Repository and Multiarchitecture
Each program is installed through a dedicated script for "AM" and from the ["AM" repository](https://github.com/ivan-hc/AM-application-manager/tree/main/programs)" and divided by architecture.
	
###### NOTE that currently my work focuses on applications for x86_64 architecture, but it is possible to extend "AM" (and then AppMan too) to all other available architectures.

Click on the link of your architecture to see the list of all the apps available on the repository of "AM" Application Manager:

- [x86_64](https://raw.githubusercontent.com/ivan-hc/AM-application-manager/main/programs/x86_64-apps)
- [i686](https://raw.githubusercontent.com/ivan-hc/AM-application-manager/main/programs/i686-apps)
- [aarch64](https://raw.githubusercontent.com/ivan-hc/AM-application-manager/main/programs/aarch64-apps)

## How to add applications
AppMan uses the same installation scripts of "AM" and changes some internal parts to made them compatible with an installation into the local folder of the user, so to add applications on AppMan you must upload them on the main repository of "AM", at https://github.com/ivan-hc/AM-Application-Manager

Here is a guide on how to create your own script for "AM": 

[Guide: your first script to install or download Applications using "AM"](https://github.com/ivan-hc/AM-application-manager/wiki/Guide:-your-first-script-to-install-or-download-Applications-using-%22AM%22)

If you are interested, you can deliberately join this project.

## Known issues
Sometime you may have difficults in starting from the applications menu and the only way to solve is to edit manually the "`Exec=`" entry in the related launcher located in `~/.local/share/applications/`, named `AM-$PROGRAM.desktop` (where `$PROGRAM` is the name of the program you are interested in), maybe this way:

    Exec=$PROGRAM
or
 
    Exec=~/.local/bin/$PROGRAM
or directly

    Exec=~/.opt/$PROGRAM/$PROGRAM
do the same for the "`Icon=`" entry in case the icon cannot be shown.    
 

## Uninstall
To completelly remove AppMan use this command:

 `sudo /opt/appman/remove`

# About "AM" Application Manager
["AM"](https://github.com/ivan-hc/AM-application-manager) is a new Application Manager I've done, initially inspired by the first releases of AppMan. "AM" is built to allow integration in the system and automatic updates for each application.

"AM"'s goal is to provide a free and open source App Manager that works on many other architectures (including and not limited to i386 and ARM). "AM" allows the installation, deletion and search of standalone programs and AppImages. Each program (or $APP) is stored in a dedicated /opt/$APP directory, the binary is more ofthen called by a custom script named "AM-updater" and it can update the program to the last version (if available) by comparing the number of version of the installed binary and the version available in the repository of the developer.

To upload a program it is necessary just one script that adds a launcher and icon (if needed), a script to use and update the program and a script to remove it with or without "AM".

To learn more about this new Application Manager, check the repository of the project at [ivan-hc/AM-application-manager](https://github.com/ivan-hc/AM-application-manager) and work at this project with me, if you're interested. I will try to give you all the tools you need to compile your own script.

Newer versions of AppMan are based on "AM" and can convert its installation scripts for a local configurations into your home directory.

# Conclusions
AppMan has a somewhat bizarre history, as it was predecessor of "AM" before, which had to correct its mistakes, and a more efficient tool improved several months later, then, using the same scripts as "AM".

Having encouraged you to visit this page is already a huge achievement for me, being AppMan my really first creation on GitHub. I'm not a developer, but a simple enthusiast who in my spare time tries to learn new things and then convert them into something more useful for the community. If only I had enough time I would devote myself completely to this, but I can't. I love to stay here because I express myself this way, and this means to spend a lot of hours of my free time on the PC trying to write scripts.

If you wish, you can support me, this work and my passion with a small [donation](https://paypal.me/ivanalexhc), I will gladly appreciate it. Thank you.
