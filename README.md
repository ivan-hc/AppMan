"AppMan" is a bash script able to install, update and remove thousands of standalone programs (any AppImage package, but also the official versions of Firefox, Thunderbird, Brave, Blender and hundreds of other programs provided on their official sites).

Since the new 4.0.0 version, AppMan is also portable, ie it does not need a speciphic path to work, you can use it anywhere on your system.

"AppMan" is based on the previous stable version of ["AM" Application Manager](https://github.com/ivan-hc/AM-Application-Manager) and converts all the installation scripts from the main database of "AM" to scripts that can install and integrate all the programs for the current user only and without root privileges. As opposed to "AM", AppMan installs all the programs locally, in the user's $HOME.

Being "AppMan" a bash-based script, it can be used on all the architectures supported by the Linux kernel and works with all the GNU/Linux distributions.

------------------------------------------------------------------------
[Introducing "AppMan"](#introducing-appman)
- [How it works](#how-it-works)
- [What programs can be installed](#what-programs-can-be-installed)
- [Repository and Multiarchitecture](#repository-and-multiarchitecture)

[Installation](#installation)

[Usage](#usage)

[Features](#features)
- [How to enable bash completion](#how-to-enable-bash-completion)
- [Snapshots: backup your app and restore to a previous version](#snapshots-backup-your-app-and-restore-to-a-previous-version)

[Uninstall](#uninstall)

[Known issues](#known-issues)

[Conclusions](#conclusions)

-----------------------------------------------------------------------------
# Introducing "AppMan"
AppMan is an application manager for AppImages and other standalone programs that works like APT or Pacman.

The main goal of this tool is to provide the same updated applications to multiple GNU/Linux distributions without having to change the package manager or the distro itself. This means that whatever distro you use, you will not miss your favorite programs or the need for a more updated version. AppMan also aims to be a merger for GNU / Linux distributions, using not just AppImage as the main package format, but also other standalone programs, so without having to risk breaking anything on your system: no daemons, no shared libraries. Just your program and your launcher.

[AppImage](https://appimage.org/) is a standalone package format, the best choice if you are looking for an alternative packaging format to use on multiple GNU/Linux distributions, it uses fewer resources than Snap and Flatpak, and works completely autonomously, using its own libraries. AppMan aims to give it a home to stay.

## How it works
All AppMan does is to convert [all the installation scripts for "AM"](https://github.com/ivan-hc/AM-Application-Manager/tree/main/programs) (that normally must be executed with ROOT privileges) in normal scripts that can manage applications in the local folder of the current user. This allows more users to be able to better configure their profile.
 
## What programs can be installed
AppMan installs/removes/updates/manages only standalone programs, ie those programs that can be run from a single directory in which they are contained (where `$PROGRAM` is the name of the application, AppMan installs them always into a dedicated folder named `~/.opt/$PROGRAM`, or into a different one if you set it with the `--apps-path` option).

These programs are taken:
- from official sources (see Firefox, Thunderbird, Blender, NodeJS, Chromium Latest...);
- from official .deb packages (see Brave, Vivaldi, Google Chrome...);
- from the repositories and official sites of individual developers (if an archive is not available, an official AppImage is used, see Libreoffice, OnlyOffice);
- from tar archives of other GNU/Linux distributions (see Chromium, Chromium Ungoogled...);
- from AUR or other Arch Linux-related sources (see Palemoon, Spotify, WhatsApp...);
- from AppImage recipes to be compiled with [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit) (see Anydesk, qBittorrent, Dropbox, all the games from the "KDE Games" suite...);
- from unofficial repositories of developers external to the project concerned (most of the time they are programs in AppImage format), but only if an official release is not available (see the various WINE, Zoom, VLC, GIMP...).

"AppMan" can even create Firefox profiles to run as webapps (as an alternative to the countless Electron-based apps/AppImages)!

You can consult basic information, links to sites and sources used through the related `appman -a $PROGRAM` command or by clicking on the related section of the "AM" repository, [here](https://github.com/ivan-hc/AM-application-manager/tree/main/programs/.about).

## Repository and Multiarchitecture
Each program is installed through a dedicated script, and all these scripts are listed in the "[AM repository](https://github.com/ivan-hc/AM-application-manager/tree/main/programs)" and divided by architecture.

Click on the link of your architecture to see the list of all the apps available on the "AM" repository:

- [x86_64](https://raw.githubusercontent.com/ivan-hc/AM-application-manager/main/programs/x86_64-apps)
- [i686](https://raw.githubusercontent.com/ivan-hc/AM-application-manager/main/programs/i686-apps)
- [aarch64](https://raw.githubusercontent.com/ivan-hc/AM-application-manager/main/programs/aarch64-apps)

If you are interested, you can deliberately join the "AM" project.

-----------------------------------------------------------------------------

# Installation
#### Step-by-step
1. Enable `~/.local/bin` in your `$PATH`:
	
       mkdir -p ~/.local/bin && echo 'export PATH=$PATH:$(xdg-user-dir USER)/.local/bin' >> ./.bashrc
2. Download the script from this repository and made it executable:

       wget -q https://raw.githubusercontent.com/ivan-hc/AppMan/main/appman-portable -O appman && chmod a+x ./appman
3. Optionally you can place the script in your new local $PATH:

       mv ./appman ~/.local/bin/appman 
       
#### Quick
Just copy/paste the following line:

    mkdir -p ~/.local/bin && echo 'export PATH=$PATH:$(xdg-user-dir USER)/.local/bin' >> ./.bashrc && wget -q https://raw.githubusercontent.com/ivan-hc/AppMan/main/appman-portable -O appman && chmod a+x ./appman && mv ./appman ~/.local/bin/appman 
    
# Choose the directory for your applications
Run `appman` (if in `$PATH`) or `./appman`, you'll read a prompt that asks for a destination directory or path for your installed Applications.
You can always modify the destination folder by editing the "appman-config" file under ~/.config/appman

-----------------------------------------------------------------------------
# Usage
  `-a`, `about` Shows the basic information, links and source of each app:
  
    appman -a $PROGRAM
-----------------------------------------------------------------------------
  `-b`, `backup` Save the current version of a program you are interested in, the snapshot will be stored in /home/$USER/.am-snapshots/$PROGRAM (see "-o"): 
  
    appman -b $PROGRAM
-----------------------------------------------------------------------------
  `-c`, `clean` Removes all the unnecessary files:
  
    appman -c
-----------------------------------------------------------------------------
  `-conv`, `convert` Convert one or more scripts downloaded (see the `-d` option) or created (see the `-t` option) for "AM" to installation scripts that can install all the applications locally. This allows you to create all the installation scripts you want without having to wait them to be created for "AM" first:
  
    appman -conv $PROGRAM
-----------------------------------------------------------------------------
  `-d`, `download` Download an installation script from the "AM" repository to your desktop without installing it:
  
    appman -d $PROGRAM
-----------------------------------------------------------------------------  
  `-f`, `files` Shows the installed programs managed by "AppMan":
  
    appman -f
-----------------------------------------------------------------------------
  `-h`, `help` Prints this message:
  
    appman -h
-----------------------------------------------------------------------------
  `-i`, `install` Install a program. This will be downloader/created into a dedicated ~/.opt/$PROGRAM directory (containing a script to remove it and  another one to update it), the command is linked to ~/.local/bin and a launcher AM-$PROGRAM.desktop will be created in ~/.local/share/applications:
  
    [sudo] appman -i $PROGRAM
-----------------------------------------------------------------------------
  `-l`, `list` Shows the list of apps available in the "AM" repository:
  
    appman -l
-----------------------------------------------------------------------------
  `-o`, `overwrite` Overwrite the existing version of the program with a saved snapshot from /home/$USER/.am-snapshots/$PROGRAM (see "-b"):
  
    appman -o $PROGRAM
-----------------------------------------------------------------------------
  `-q`, `query` Use one or more keywords to search for in the list of available applications:
  
    appman -q $KEYWORD
-----------------------------------------------------------------------------
  `-r`, `remove` Removes the program and all the other files listed above using the instructions in ~/.opt/$PROGRAM/remove. Confirmation is required (Y or N, default is Y):
  
    [sudo] appman -r $PROGRAM
-----------------------------------------------------------------------------
  `-s`, `sync` Updates "AppMan" to a more recent version:
  
    appman -s
-----------------------------------------------------------------------------
  `-t`, `template` This option allows you to generate a custom script for "AM" from a list of different templates that may be vary according to the kind of $PROGRAM you want to create/install/update. Once you choose a number, the script will download the template by renaming it using the argument "$PROGRAM" you provided above:
  
    appman -t $PROGRAM
-----------------------------------------------------------------------------
  `-u`, `update` Update all the installed programs:
  
    appman -u
   To update just one program and read the shell's output:

    appman -u $PROGRAM
-----------------------------------------------------------------------------
  `-v`, `--version`, `version` Shows the version of "AppMan":
  
    appman -v
-----------------------------------------------------------------------------
  `-w`, `web` Shows the URLs of the sites/sources of $PROGRAM:
  
    appman -w $PROGRAM
-----------------------------------------------------------------------------
  `--disable-completion` Disable bash completion (see the next option):
  
    appman --disable-completion
-----------------------------------------------------------------------------
  `--enable-completion` Enable bash completion (this will add two lines in your ~/.bash_completion file) to complete a keyword with the TAB key using the names of all installable applications:
  
    appman --enable-completion
-----------------------------------------------------------------------------
  `lock` Lock the selected $PROGRAM to the current installed version, this only works if a dedicated "AM-updater" script exists:
  
    appman lock $PROGRAM
-----------------------------------------------------------------------------
  `unlock` Unlock updates for the selected $PROGRAM. This option nulls "lock", the update file is renamed as "AM-updater" again, so that it can be intercepted when executing the "appman -u" command (see "-u"):
  
    appman unlock $PROGRAM
-----------------------------------------------------------------------------

# Features
------------------------------------------------------------------------
### How to enable bash completion
"AppMan" has its inbuilt bash completion script that can be enabled using the following command:

    appman --enable-completion
This will create (if it not exists) a ~/.bash_completion script in your $HOME, needed to complete a keyword with the TAB key using the names of all the main options and the name of the scripts of all the applications available in the "AM" repository.
To disable bash completion:

    appman --disable-completion

------------------------------------------------------------------------
### Snapshots: backup your app and restore to a previous version
"AppMan" supports snapshots of all installed applications. A selected program can be copied locally into your home folder.

- option `-b` or `backup` creates the snapshot, usage:

      appman -b $PROGRAM
- option `-o` or `overwrite` allows you to roll back to a previous version of the program. Usage:

      appman -o $PROGRAM
All the snapshots are stored into an hidden `/home/$USER/.am-snapshots` folder containing other subfolders, each one has the name of the programs you've done a backup before. Each snapshot is named with the date and time you have done the backup. To restore the application to a previous version, copy/paste the name of the snapshot when the `-o` option will prompt it.

------------------------------------------------------------------------
# Uninstall
To uninstall "AppMan" just run the command:

	sudo appman -r appman

------------------------------------------------------------------------	
# Known issues
"AppMan" itself works well, but there are a few things to consider before, after and during use:
- The "AppMan" scripts use the basic commands usually found in any GNU / Linux distribution (wget, curl, grep, egrep, find, rm, mkdir, mv, ls, echo...), make sure you have them before performing any operation;
- The task of "AppMan" is solely to install / remove / update the applications managed by it. Problems related to the failure of an installed program or any related bugs are attributable solely to its developers. You can view the link to each project's repository or official site via the "`appman -a $PROGRAM`" command;
- The developer of AM has compiled the application installation scripts based on any links made publicly available by the owners of the affected software (or from official repositories of other progressive release distributions, for example Debian Unstable, Arch Linux, Slackware ...) . These urls (with particular reference to the official ones of the developers) may not work in the future if the developers decide to modify the site, the tags, the repository or any detail that the script refers to to install / update the application. In this case, [please report the problem to the "AppMan" team](https://github.com/ivan-hc/AM-application-manager/issues) who will modify or (in the worst case) remove the installation script until the problem is resolved;
- "AppMan" is an open source project, you can read and compile the scripts to your liking, as long as they don't damage your system. All scripts have been tested on Debian Testing / Unstable (64 bit) and Debian 11 (32 bit) and should work on any GNU / Linux distribution, regardless of the initialization process (with or without systemd).

------------------------------------------------------------------------
# Conclusions
AppMan has a somewhat bizarre history, as it was predecessor of "AM" before, which had to correct its mistakes, and a more efficient tool improved several months later, then, using the same scripts as "AM".

Having encouraged you to visit this page is already a huge achievement for me, being AppMan my really first creation on GitHub. I'm not a developer, but a simple enthusiast who in my spare time tries to learn new things and then convert them into something more useful for the community. If only I had enough time I would devote myself completely to this, but I can't. I love to stay here because I express myself this way, and this means to spend a lot of hours of my free time on the PC trying to write scripts.

If you wish, you can support me, this work and my passion with a small [donation](https://paypal.me/ivanalexhc), I will gladly appreciate it. Thank you.
