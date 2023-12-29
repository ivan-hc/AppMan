"AppMan" is a bash script able to install, update and remove thousands of standalone programs (any AppImage package, but also the official versions of Firefox, Thunderbird, Brave, Blender and hundreds of other programs provided on their official sites).

Since the new 4.0.0 version, AppMan is also portable, ie it does not need a speciphic path to work, you can use it anywhere on your system.

"AppMan" is based on the previous stable version of ["AM" Application Manager](https://github.com/ivan-hc/AM-Application-Manager) and converts all the installation scripts from the main database of "AM" to scripts that can install and integrate all the programs for the current user only and without root privileges. As opposed to "AM", AppMan installs all the programs locally, in the user's $HOME.

"AppMan" can also be used by "AM" itself, since version 4.3.3-1 of the main project exists the option `--user` that allows you to create an alias to install and manage apps in your $HOME folder. When executing the `am --user` command you will be suggested an alias to use temporarily or if you want you can add it in your ~/.bashrc to make it permanent. "AppMan" will be used while still using the usual `am` command (learn more [here](https://github.com/ivan-hc/AM-Application-Manager#use-am-locally-like-appman-does)).

Being "AppMan" a bash-based script, it can be used on all the architectures supported by the Linux kernel and works with all the GNU/Linux distributions.

------------------------------------------------------------------------
[Introducing "AppMan"](#introducing-appman)
- [How it works](#how-it-works)
- [What programs can be installed](#what-programs-can-be-installed)
- [Repository and Multiarchitecture](#repository-and-multiarchitecture)

[Installation](#installation)
- [Requirements](#requirements)
  - [Dependences](#dependences)
  - [Optional-dependences](#optional-dependences)
- [Step-by-step](#step-by-step)
- [Quick](#quick)
- [Portable Mode](#portable-mode)

[Choose the directory for your applications](#choose-the-directory-for-your-applications)

[Usage](#usage)

[Features](#features)
- [How to enable bash completion](#how-to-enable-bash-completion)
- [Snapshots: backup your app and restore to a previous version](#snapshots-backup-your-app-and-restore-to-a-previous-version)
- [Rollback](#rollback)
- [Manage local AppImages](#manage-local-appimages)
- [Sandbox using Firejail](#sandbox-using-firejail)

[Uninstall](#uninstall)

[Troubleshooting](#troubleshooting)
- [An application does not work, is old and unsupported](#an-application-does-not-work-is-old-and-unsupported)
- [Cannot download or update an application](#cannot-download-or-update-an-application)
- [Cannot mount and run AppImages](#cannot-mount-and-run-appimages)
- [Missing dependences](#missing-dependences)
- [Spyware, malware and dangerous software](#spyware-malware-and-dangerous-software)
- [Stop AppImage prompt to create its own launcher, desktop integration and doubled launchers](#stop-appimage-prompt-to-create-its-own-launcher-desktop-integration-and-doubled-launchers)
- [Wrong download link](#wrong-download-link)

[Conclusions](#conclusions)

-----------------------------------------------------------------------------
# Introducing "AppMan"
AppMan is an application manager for AppImages and other standalone programs that works like APT or Pacman.

The main goal of this tool is to provide the same updated applications to multiple GNU/Linux distributions without having to change the package manager or the distro itself. This means that whatever distro you use, you will not miss your favorite programs or the need for a more updated version. AppMan also aims to be a merger for GNU / Linux distributions, using not just AppImage as the main package format, but also other standalone programs, so without having to risk breaking anything on your system: no daemons, no shared libraries. Just your program and your launcher.

[AppImage](https://appimage.org/) is a standalone package format, the best choice if you are looking for an alternative packaging format to use on multiple GNU/Linux distributions, it uses fewer resources than Snap and Flatpak, and works completely autonomously, using its own libraries. AppMan aims to give it a home to stay.

-----------------------------------------------------------------------------
## How it works
All AppMan does is to convert [all the installation scripts for "AM"](https://github.com/ivan-hc/AM-Application-Manager/tree/main/programs) (that normally must be executed with ROOT privileges) in normal scripts that can manage applications in the local folder of the current user. This allows more users to be able to better configure their profile. AppMan allows you to choose where to install your applications into your `$HOME` directory. AppMan is also usable as a portable app (i.e. you can download and place it wherever you want) and it is able to update itself, anywhere! At first start it will ask you where to install the apps and it will create the directory for you (the configuration file is in `~/.config/appman`). For example, suppose you want install everything in "Applicazioni" (the italian of "applications"), this is the structure of what an installation scripts installs with "AppMan" instead:

    ~/Applicazioni/$PROGRAM/
    ~/Applicazioni/$PROGRAM/$PROGRAM
    ~/Applicazioni/$PROGRAM/AM-updater
    ~/Applicazioni/$PROGRAM/remove
    ~/Applicazioni/$PROGRAM/icons/$ICON-NAME
    ~/.local/bin/$PROGRAM
    ~/.local/share/applications/AM-$PROGRAM.desktop

To install a program, launch the command:

    appman -i $PROGRAM

To update all the apps at once just run the following command:

    appman -u

To uninstall everything just run:

    appman -R $PROGRAM

For more options, jump to "[Usage](#usage)" or keep read.

-----------------------------------------------------------------------------
## What programs can be installed
AppMan installs/removes/updates/manages only standalone programs, ie those programs that can be run from a single directory in which they are contained (where `$PROGRAM` is the name of the application, AppMan installs them always into a directory you choose the first time you run it thanks to a prompt that will ask you where to install your apps (for example you can create an "Applications" or "Programs" or "Whatever-name-you-want" folder named "Applicazioni" or "Programmi" or "Qual-si-voglia" instead if your system language is italian, to prevent the discrepanchy of your folder's name compared to the other available in your `$HOME` directory).

These programs are taken:
- from official sources (see Firefox, Thunderbird, Blender, NodeJS, Chromium Latest, Platform Tools...);
- from official .deb packages;
- from the repositories and official sites of individual developers;
- from tar archives of other GNU/Linux distributions;
- from AUR or other Arch Linux-related sources;
- from AppImage recipes to be compiled with [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit);
- from unofficial repositories of developers external to the project concerned (most of the time they are programs in AppImage format), but only if an official release is not available (see the various WINE, Zoom, VLC, GIMP, OBS Studio...).

"AppMan" can even create Firefox profiles to run as webapps (as an alternative to the countless Electron-based apps/AppImages)!

You can consult basic information, links to sites and sources used through the related `appman -a $PROGRAM` command or by connecting to https://portable-linux-apps.github.io

-----------------------------------------------------------------------------
## Repository and Multiarchitecture
Each program is installed through a dedicated script, and all these scripts are listed in the "[AM repository](https://github.com/ivan-hc/AM-application-manager/tree/main/programs)" and divided by architecture.

Click on the link of your architecture to see the list of all the apps available on the "AM" repository:

- [x86_64](https://raw.githubusercontent.com/ivan-hc/AM-application-manager/main/programs/x86_64-apps)
- [i686](https://raw.githubusercontent.com/ivan-hc/AM-application-manager/main/programs/i686-apps)
- [aarch64](https://raw.githubusercontent.com/ivan-hc/AM-application-manager/main/programs/aarch64-apps)

If you are interested, you can deliberately join the "AM" project.

-----------------------------------------------------------------------------
# Installation
AppMan can either be used in Portable Mode (ideal if you want to put it on a USB stick to use on any system) or placed into a $PATH enabled in your $HOME directory (and without root privileges). In the following lines you can choose an installation guide or you can start it immediately in Portable Mode (with a video)... but not before having read the list of dependencies needed to run "AppMan".

NOTE that by installing AppMan in ~/.local/bin, the script can also be managed by Topgrade (see https://github.com/topgrade-rs/topgrade). Follow the "[Step-by-step](#step-by-step)" guide (the paragraph after "[Requirements](#requirements)", in this page).

### Requirements
#### Dependences
A warning message will prevent you from using "AM"/AppMan if the following packages are not installed on your system:
- "`cat`", "`chmod`" and "`chown`" (available in "`coreutils`");
- "`curl`", to check URLs;
- "`grep`", to check files;
- "`sed`", to edit/adapt installed files;
- "`wget`" to download all programs and update "AM"/AppMan itself.

#### Optional dependences
The following dependences are optional for "AM" and AppMan themself, but to prevent installation/update errors for some kind of packages, its strongly recommended to install them:
- "`ar`" (available in "`binutils`") is needed to extract .deb packages (that are very few in this repository);
- "`unzip`", to extract .zip packages;
- "`tar`", to extract .tar* packages;
- "`zsync`", about 10% of AppImages depend on this to be updated.

From version 5.2 you can continue to use "AM"/AppMan without the aforementioned dependencies, but a message will appear recommending you to install them, to avoid problems in the future.

For more details, jump to the paragraph "[Missing dependences](#missing-dependences)", under the section "[Troubleshooting](#troubleshooting)".

NOTE: as you can see, unlike "AM" (that require `sudo`), it is not absolutely necessary to run "AppMan" with root privileges, however if out of habit you intend to use `sudo`, `doas` or similar commands you are free to do so at your own risk (I don't recommend it, all the options may require root access each time you run `appman`, and this is less convenient than by using `am`, at this point).

-----------------------------------------------------------------------------
#### Step-by-step
1. Enable `~/.local/bin` in your `$PATH`:
	
       mkdir -p ~/.local/bin && echo 'export PATH=$PATH:$(xdg-user-dir USER)/.local/bin' >> ~/.bashrc
2. Download the script from this repository and made it executable:

       wget https://raw.githubusercontent.com/ivan-hc/AppMan/main/appman && chmod a+x ./appman
3. Optionally you can place the script in your new local $PATH:

       mv ./appman ~/.local/bin/appman 

-----------------------------------------------------------------------------
#### Quick
Just copy/paste the following line:

    mkdir -p ~/.local/bin && echo 'export PATH=$PATH:$(xdg-user-dir USER)/.local/bin' >> ~/.bashrc && wget https://raw.githubusercontent.com/ivan-hc/AppMan/main/appman && chmod a+x ./appman && mv ./appman ~/.local/bin/appman 

-----------------------------------------------------------------------------
#### Portable Mode
As we have just seen, it is more convenient to put the scipt of "AppMan" into a local $PATH to use it from the command line and use `bash-completion` like on any other program in your system. But we have not to forget that "AppMan" is a portable version of "AM", this means that you can use it wherever you want, this mean that you can also setup an USB stick with a custom $HOME to use your apps wherever you want.

In this video I'll show you how it is easy to use AppMan quickly in any directory you download it:

https://github.com/ivan-hc/AppMan/assets/88724353/f70c46fd-6509-4889-b119-ecb386a623ad

In this case all you have to do is to copy/paste the following command:

       wget https://raw.githubusercontent.com/ivan-hc/AppMan/main/appman && chmod a+x ./appman

-----------------------------------------------------------------------------
# Choose the directory for your applications
Run `appman` (if in `$PATH`) or `./appman`, you'll read a prompt that asks for a destination directory or path for your installed Applications.
You can always modify the destination folder by editing the "appman-config" file under ~/.config/appman

-----------------------------------------------------------------------------
# USAGE
 
 `appman {OPTION}`
 
 `appman {OPTION} {PROGRAM}`
 ___________________________________________________________________________
 
 ###########################################################################
 ___________________________________________________________________________
 
 OPTIONS 
 				
 (standard, for both "AM" AND "APPMAN")
 ___________________________________________________________________________
 ___________________________________________________________________________
 
 `-a`, `about`
 
 SYNOPSIS:

 `-a {PROGRAM}`
 
 DESCRIPTION: 	Shows more info about one or more apps, all the pages are downloaded from https://portable-linux-apps.github.io
 ___________________________________________________________________________
 
 `-b`, `backup`
 
 SYNOPSIS:

 `-b {PROGRAM}`
 
 DESCRIPTION:	Save the current version of one or more apps, each snapshot is stored into a dedicated directory, under $HOME/.am-snapshots/$PROGRAM
 
 To restore the snapshots see the "-o" option.
 ___________________________________________________________________________
 
 `-c`, `clean`
 
 SYNOPSIS:

 `-c`
 
 DESCRIPTION:	Removes all the unnecessary files and folders.
 ___________________________________________________________________________
 
 `-d`, `download`
 
 SYNOPSIS:

 `-d {PROGRAM}`
 
 DESCRIPTION:	Download one or more installation scripts to your desktop.
 ___________________________________________________________________________
 
 `-f`, `files`
 
 SYNOPSIS:

 `-f`
 
 DESCRIPTION:	Shows the list of all installed programs, with sizes.
 ___________________________________________________________________________
 
 `-h`, `help`
 
 SYNOPSIS:

 `-h`
 
 DESCRIPTION:	Prints this message.
 ___________________________________________________________________________
 
 `-H`, `--home`
 
 SYNOPSIS:

 `-H {PROGRAM}`
 
 DESCRIPTION:	Set a dedicated $HOME directory for one or more AppImages.
 ___________________________________________________________________________
 
 `-i`, `install`
 
 SYNOPSIS:

 `-i {PROGRAM}`
 
 DESCRIPTION:	Install one or more programs.
 ___________________________________________________________________________
 
 `-l`, `list`
 
 SYNOPSIS:

 `-l`
 
 DESCRIPTION:	Shows the list of all the apps available in the repository.
 ___________________________________________________________________________
 
 `-o`, `overwrite`
 
 SYNOPSIS:

 `-o {PROGRAM}`
 
 DESCRIPTION:	Overwrite the existing version of the app with a snapshot saved previously (see the option "-b", above).
 ___________________________________________________________________________
 
 `-q`, `query`
 
 SYNOPSIS:

 `-q {KEYWORD}`
 
 DESCRIPTION:	Can be used to search for keywords and terms in the list of available applications packages to display matches. This can be useful if you are looking for applications having a specific feature.
 ___________________________________________________________________________
 
 `-r`, `remove`
 
 SYNOPSIS:

 `-r {PROGRAM}`
 
 DESCRIPTION:	Removes one or more apps, requires confirmation.
 ___________________________________________________________________________
 
 `-R`
 
 SYNOPSIS:

 `-R {PROGRAM}`
 
 DESCRIPTION:	Removes one or more apps without asking.
 ___________________________________________________________________________
 
 `-s`, `sync`
 
 SYNOPSIS:

 `-s`
 
 DESCRIPTION:	Updates this script to the latest version hosted.
 ___________________________________________________________________________
 
 `-t`, `template`
 
 SYNOPSIS:

 `-t {PROGRAM}`
 
 DESCRIPTION:	This option allows you to generate a custom script from a list of different templates that may be vary according to the kind of app you want to upload to the "AM" repo, and the source where it is available.
 ___________________________________________________________________________
 
 `-u`, `-U`, `update`
 
 SYNOPSIS:

 `-u`
 
 `-u {PROGRAM}`
 		
 DESCRIPTION: Update all the apps or just one.
 ___________________________________________________________________________
 
 `-v`, `version`
 
 SYNOPSIS:

 `-v`
 
 DESCRIPTION:	Shows the version.
 ___________________________________________________________________________
 
 `-w`, `web`
 
 SYNOPSIS:

 `-w`
 
 DESCRIPTION:	Shows the URLs of the sites/sources of then app.
 ___________________________________________________________________________
 
 `--disable-completion`
 
 SYNOPSIS:

 `--disable-completion`
 
 DESCRIPTION:	Disable bash-completion.
 ___________________________________________________________________________
 
 `--enable-completion`
 
 SYNOPSIS:

 `--enable-completion`
 
 DESCRIPTION:	Enable bash-completion to complete a keyword with the "TAB" key, using the names of all installable applications available.
 ___________________________________________________________________________
 
 `--firejail`, `--sandbox`
 
 SYNOPSIS:

 `--firejail {PROGRAM}`
 
 DESCRIPTION:	Run an AppImage in a sandbox using Firejail.
 ___________________________________________________________________________

 `--launcher`
 
 SYNOPSIS:
 
 `--launcher /path/to/${APPIMAGE}`

 DESCRIPTION:	Embed one or more local AppImages in the applications menu. I suggest dragging the files into the terminal to get the desired effect. Launchers are located in ~/.local/share/applications/AppImages by default.
 ___________________________________________________________________________

  `--rollback`

 SYNOPSIS:

 `--rollback {PROGRAM}`

 DESCRIPTION:	Download an older or specific version of the software you are interested in (only works with Github).
 ___________________________________________________________________________ 
 
 `lock`
 
 SYNOPSIS:

 `lock {PROGRAM}`
 
 DESCRIPTION:	Lock the selected app to the current version installed, this only works if exists a dedicated "AM-updater" installed with the app.
 ___________________________________________________________________________
 
 `unlock`
 
 SYNOPSIS:

 `unlock {PROGRAM}`
 
 DESCRIPTION:	Unlock updates for the selected program. This option nulls the option "lock" (see above).
 ___________________________________________________________________________
 ___________________________________________________________________________

 EXTRA OPTIONS (only available for "APPMAN")
 ___________________________________________________________________________

 `conv`, `convert`
 
 SYNOPSIS:

 `conv {PROGRAM}`
 
 DESCRIPTION:	Download the installation scripts for "AM" and converts them to rootless installation scripts that can be installed locally. 
 ___________________________________________________________________________
    
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
# Rollback
From version 4.4 it is possible to directly select from a list of URLs the version of the app that interests you most from the main source. Use the `--rollback` option in this mode:
```
appman --rollback ${PROGRAM}
```
This only works with the apps hosted on Github.

------------------------------------------------------------------------
# Manage local AppImages
Since version 4.4.2 you can use the `--launcher` option to integrate your local AppImage packages by simply dragging and dropping them into the terminal (see video).

https://github.com/ivan-hc/AM-Application-Manager/assets/88724353/c4b889f4-8504-4853-8918-44d52084fe6c

------------------------------------------------------------------------
# Sandbox using Firejail
Since version 5.3 you can use the `--firejail` option to run AppImages using a sandbox (requires Firejail installed on the host).

At first start a copy of /etc/firejail/default.profile will be saved in your application's directory, so you're free to launch the AppImage once using the default Firejail profile (option 1) or the custom one (2), you can also patch the .desktop files (if available) to in sandbox-mode always (options 3 and 4). You can handle the custom firejail.profile file of the app using `vim` or `nano` using the option 5 (the first selection is `vim`).

Options 1, 2 and 5 are continuous to let you edit the file and test your changes immediately. Press any key to exit.

NOTE: once patched the .desktop files (options 3 and 4), they will be placed in ~/.local/share/applications, this means that if you have installed apps using AppMan, the original launchers will be overwrited.

------------------------------------------------------------------------	
# Uninstall
To uninstall "AppMan" just remove it. To uninstall all the apps installed instead it is necessary to execute the `remove` script available into the main directory of each application you've installed (with "AppMan" it is easier with the `appman -r $PROGRAM1 $PROGRAM2 $PROGRAM3 ...` command.
The configuration's file of "AppMan" (the one containing the name of the directory you've choosen for your apps) is available in ~/.config/appman.

------------------------------------------------------------------------	
# Troubleshooting

------------------------------------------------------------------------
### An application does not work, is old and unsupported
Use the `-a` option and go to the developer's site to report the problem. The task of "AppMan" is solely to install / remove / update the applications managed by it. Problems related to the failure of an installed program or any related bugs are attributable solely to its developers.

------------------------------------------------------------------------
### Cannot download or update an application
There can be many reasons:
- check your internet connection;
- if the app is hosted on github.com, you have probably exceeded the hourly limit of API calls;
- the referring link may have been changed, try the `--rollback` option;
- the reference site has changed, report any changes at https://github.com/ivan-hc/AM-Application-Manager/issues

------------------------------------------------------------------------
### Cannot mount and run AppImages
See https://docs.appimage.org/user-guide/troubleshooting/fuse.html

------------------------------------------------------------------------
### Missing dependences
To prevent any issue is strongly recommended to install all dependences listed at the paragraph "[Requirements](#requirements)", alternativelly you can use this workaround.

Open the file `/opt/am/APP-MANAGER` with a text editor and change the following line (do this for each update):
```
for name in "ar" "unzip" "tar" "zsync"; do
```

Example, "`ar`" is included in `binutils` and it is used by few installation scripts to extract .deb packages. If you don't plan to install "`vivaldi`" in aarch64, "`windows95`" in x86_64 or "`ocenaudio`" in i686, change the line above like this:
```
for name in "unzip" "tar" "zsync"; do
```
In addition, the command "`zsync`" is used to update some AppImage packages. Until now the installation scripts for x86_64 that include this as a dependence are more than 220, so without it you can't update these Appimages. If this is not a problem for you, can chamge the line above like this:
```
for name in "unzip" "tar"; do
```
I don't recommend to remove all other commands, being them mainly used. 

------------------------------------------------------------------------
### Spyware, malware and dangerous software
Before installing any application, try to know where it comes from first. This program provides you with two basic options for this purpose:
- Option `-a` or `about` (medium safety), allows you to read a short description and know the links from the pages of the site [https://portable-linux-apps.github.io](https://portable-linux-apps.github.io) locally, however these links may be inaccurate due to continuous updates of the initial scripts (you can provide additional info yourself by modifying the pages of the site, [here](https://github.com/Portable-Linux-Apps/Portable-Linux-Apps.github.io), it is also open source);
- Option `-d` or `download` (absolute safety), this allows you to get the installation script directly on your desktop, so you can read the mechanisms and how it performs the downloads from the sources (in most cases there is a header for each step that explains what the listed commands do).

“AM” and AppMan are just tools to easily install all listed programs, but what you choose to install is your complete responsibility. **Use at your own risk**!

------------------------------------------------------------------------
### Stop AppImage prompt to create its own launcher, desktop integration and doubled launchers
Some developers insist on creating Appimages that create their own launcher on first launch (like WALC and OpenShot). If the official solution proposed [here](https://discourse.appimage.org/t/stop-appimage-from-asking-to-integrate/488) doesn't work, create a .home directory with the `-H` option, launch the app and accept the request. For example:
```
am -H walc
walc
```
Accept the integration request, the launcher will be saved in the walc.home directory located next to the AppImage file.

------------------------------------------------------------------------
### Wrong download link
The reasons may be two:
- the referring link may have been changed, try the `--rollback` option;
- the reference site has changed, report any changes at https://github.com/ivan-hc/AM-Application-Manager/issues

------------------------------------------------------------------------
### Stop AppImage prompt to create its own launcher, desktop integration and doubled launchers
Some developers insist on creating Appimages that create their own launcher on first launch (like WALC and OpenShot). If the official solution proposed [here](https://discourse.appimage.org/t/stop-appimage-from-asking-to-integrate/488) doesn't work, create a .home directory with the `-H` option, launch the app and accept the request. For example:
```
am -H walc
walc
```
Accept the integration request, the launcher will be saved in the walc.home directory located next to the AppImage file.

------------------------------------------------------------------------
# Conclusions
AppMan has a somewhat bizarre history, as it was predecessor of "AM" before, which had to correct its mistakes, and a more efficient tool improved several months later, then, using the same scripts as "AM".

Having encouraged you to visit this page is already a huge achievement for me, being AppMan my really first creation on GitHub. I'm not a developer, but a simple enthusiast who in my spare time tries to learn new things and then convert them into something more useful for the community. If only I had enough time I would devote myself completely to this, but I can't. I love to stay here because I express myself this way, and this means to spend a lot of hours of my free time on the PC trying to write scripts.

If you wish, you can support me, this work and my passion with a small [donation](https://paypal.me/ivanalexhc), I will gladly appreciate it. Thank you.
