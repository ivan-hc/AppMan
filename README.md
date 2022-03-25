## AppMan: install applications locally and without root privileges
#### Why a new package manager?
Many programs for GNU/Linux can work without necessarily having to mix their libraries with other programs in a completely standalone way (AppImage, but also other autonomous applications, such as Firefox, Blender and Thunderbird). The only thing they needed was a tool that could download, install, and manage them... so I thought about writing not one but two: "AM" and "AppMan".

------------------------------------------------------------------------
[Introducing "AppMan"](#introducing-appman)
- [How it works](#how-it-works)
- [Differences between "AppMan" and "AM"](#differences-between-appman-and-am)
- [What programs can be installed](#what-programs-can-be-installed)
- [How to update all programs, for real](#how-to-update-all-programs-for-real)
- [Repository and Multiarchitecture](#repository-and-multiarchitecture)
- [Comparison with other package managers](#comparison-with-other-package-managers)

[Installation](#installation)

[Usage](#usage)

[Features](#features)
- [How to enable bash completion](#how-to-enable-bash-completion)
- [Snapshots: backup your app and restore to a previous version](#snapshots-backup-your-app-and-restore-to-a-previous-version)

[Create your own script](#create-your-own-script)

[Uninstall](#uninstall)

[Known issues](#known-issues)

[Related projects](#related-projects)

[Conclusions](#conclusions)

-----------------------------------------------------------------------------
# Introducing "AppMan"
AppMan is an application manager for AppImages and other standalone programs that works like APT or Pacman.

The main goal of this tool is to provide the same updated applications to multiple GNU/Linux distributions without having to change the package manager or the distro itself. This means that whatever distro you use, you will not miss your favorite programs or the need for a more updated version. AppMan also aims to be a merger for GNU / Linux distributions, using not just AppImage as the main package format, but also other standalone programs, so without having to risk breaking anything on your system: no daemons, no shared libraries. Just your program and your launcher.

[AppImage](https://appimage.org/) is a standalone package format, the best choice if you are looking for an alternative packaging format to use on multiple GNU/Linux distributions, it uses fewer resources than Snap and Flatpak, and works completely autonomously, using its own libraries. AppMan aims to give it a home to stay.

## How it works
Since the 2.0 release, AppMan took over the base code from its own successor, ["AM" Application Manager](https://github.com/ivan-hc/AM-Application-Manager) and takes all sources from the "AM" repository itself.

If before AppMan had its own archive of scripts and icons to install programs (click [here](https://github.com/ivan-hc/AppMan/archive/refs/tags/1.8.zip) to download the old 1.8 version's source code), the project was interrupted for several months in favour of a new code base named "AM".
That code base also served to improve AppMan, which has a new life since March 2022.

All AppMan does is to convert [all the installation scripts for "AM"](https://github.com/ivan-hc/AM-Application-Manager/tree/main/programs) (that normally must be executed with ROOT privileges) in normal scripts that can manage applications in the local folder of the current user. This allows more users to be able to better configure their account.

To learn more about "AM" and all its scripts, visit the official repository at https://github.com/ivan-hc/AM-APPLICATION-MANAGER
 
-----------------------------------------------------------------------------
## Differences between "AppMan" and "AM"
"AppMan" and "AM" are two command line tools that can download, install, update, remove and save AppImage and other standalone applications trying to always get the original versions from the main sources, and where necessary, try to create AppImage using [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit). Since March 2022 "AM" provides its source code as the base for the newer releases of AppMan, making this a version of "AM" that allows you to install programs locally instead. 

Where `$PROGRAM` is the application we're going to install:
- "AppMan" (ie the `appman` command, provided by this main repository) programs and all related files are stored into a local directory named `~/.opt/$PROGRAM`, the launcher is placed into the `~/.local/share/applications` directory and the main application link is placed into a new `~/.local/bin` directory ( the latter requires to be enabled into the `~/.bashrc` file, by adding the line `export PATH=$PATH:$(xdg-user-dir USER)/.local/bin` at the end of the file), this allows a single user to costumize its local configuration without having to share applications with others in the system;
- "AM" (ie the `am` command, available at [github.com/ivan-hc/AM-APPLICATION-MANAGER](https://github.com/ivan-hc/AM-APPLICATION-MANAGER)) instead installs programs and all related files into a `/opt/$PROGRAM` directory, the launcher in `/usr/share/applications` and the main application link in a`$PATH` (i.e. `/usr/local/bin` or `/usr/games`), this allows multiple users of the same system to be able to use the same installed applications. Root privileges (`sudo`) are required only to install and remove applications.

For everything else, the controls and operation are always the same for both command line tools. The only thing that changes is that the installation scripts are written only for "AM", while "AppMan" uses the same scripts and includes commands that can modify them to make them work locally during the installation process.

More details about AM on the official repository, at https://github.com/ivan-hc/AM-APPLICATION-MANAGER

-----------------------------------------------------------------------------
## What programs can be installed
AppMan installs/removes/updates/manages only standalone programs, ie those programs that can be run from a single directory in which they are contained (where `$PROGRAM` is the name of the application, AM installs them always into a dedicated folder named `~/.opt/$PROGRAM`).

These programs are taken:
- from official sources (see Firefox, Thunderbird, Blender, NodeJS, Chromium Latest...);
- from official .deb packages (see Brave, Vivaldi, Google Chrome...);
- from the repositories and official sites of individual developers (if an archive is not available, an official AppImage is used, see Libreoffice, OnlyOffice);
- from tar archives of other GNU/Linux distributions (see Chromium, Chromium Ungoogled...);
- from AUR or other Arch Linux-related sources (see Palemoon, Spotify, WhatsApp...);
- from AppImage recipes to be compiled with [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit) (see Anydesk, qBittorrent, Dropbox, all the games from the "KDE Games" suite...);
- from unofficial repositories of developers external to the project concerned (most of the time they are programs in AppImage format), but only if an official release is not available (see the various WINE, Zoom, VLC, GIMP...).

You can consult basic information, links to sites and sources used through the related `appman -a $PROGRAM` command or by clicking on the related section of the "AM" repository, [here](https://github.com/ivan-hc/AM-application-manager/tree/main/programs/.about).

-----------------------------------------------------------------------------
## How to update all programs, for real
To update all the programs, just run the command:

	appman -u
To update just one program (and to read the output from the shell):

    appman -u $PROGRAM
Here are the ways in which the updates will be made:
- Updateable AppImages can rely on an [appimageupdatetool](https://github.com/AppImage/AppImageUpdate)-based "updater" or on their external zsync file (if provided by the developer);
- Non-updateable AppImages and other standalone programs will be replaced only with a more recent version if available, this will be taken by comparing the installed version with the one available on the source (using "curl", "grep" and "cat"), the same is for some AppImages created with [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit);
- Fixed versions will be listed with their build number (e.g. $PROGRAM-1.1.1). Note that most of the programs are updateable, so fixed versions will only be added upon request (or if it is really difficult to find a right wget/curl command to download the latest version), at https://github.com/ivan-hc/AM-APPLICATION-MANAGER

Being applications installed locally, all updates will be automatic and without root permissions.

-----------------------------------------------------------------------------
## Repository and Multiarchitecture
Each program is installed through a dedicated script, and all these scripts are listed in the "[AM repository](https://github.com/ivan-hc/AM-application-manager/tree/main/programs)" and divided by architecture.

Click on the link of your architecture to see the list of all the apps available on the "AM" repository:

- [x86_64](https://raw.githubusercontent.com/ivan-hc/AM-application-manager/main/programs/x86_64-apps)
- [i686](https://raw.githubusercontent.com/ivan-hc/AM-application-manager/main/programs/i686-apps)
- [aarch64](https://raw.githubusercontent.com/ivan-hc/AM-application-manager/main/programs/aarch64-apps)

If you are interested, you can deliberately join the "AM" project.

-----------------------------------------------------------------------------
# Comparison with other package managers
"AppMan" is not a project that wants to compete with the basic package managers of GNU/Linux distributions, being many managed programs come from different distributions (including Debian, Arch Linux and Slackware), but wants to favor the promotion of standalone programs and lighten the load of the developers of the distributions, separating the programs of the base system from those of the individual developers, in order to increase the general stability of the system and fill the shortcomings of one or of the other distribution:

### 1) "AppMan" versus APT/DNF/PacMan/any AUR helper
- Any traditional package manager follows precise patterns in integrating software and sharing libraries among the various applications in the system, and this last point can create conflicts that lead to the malfunction of one program compared to another. Furthermore, the programs differ in version according to the kind of software update model between the various distributions, the rolling-releases distributions (for example Arch Linux and Slackware) tend to always have the latest version while the fixed-release distributions (for example Debian Stable) often get older program versions.
- "AppMan" tends to get always the last version of each program from the main developer's source, and being them only standalone programs, they will be stored in just one dedicated folder, each script just need to download the standalone program into a dedicated `~/.opt/$PROGRAM` directory, creates the launcher in `~/.local/share/applications` and a link in `~/.local/bin`. In case no alternative sources are available, "AppMan" can compile and create AppImages using pkg2appimage and appimagetool, and these can be distributed on all other GNU/Linux distributions.

### 2) "AppMan" versus Flatpak
- Flatpak is one of the most popular projects for redistributing standalone programs, and many developers prefer it. However the disadvantage concerns the use of several hundreds of megabytes of libraries where required which will be re-shared with any other installed applications. What if you just want to install one application? For example, installing GIMP (300MB) requires adding a huge set of GTK libraries (800MB), while installing any QT-based application requires a set of QT libraries (700MB) which will be then shared again. In practice it is a bit like installing a virtual machine in VirtualBox in order to take advantage of a specific version of a program, and if on the one hand the application is free to work (almost) perfectly, on the other the physical memory consumption is useless and shameful;
- "AppMan" only manages standalone programs (which rarely require the installation of additional libraries on the host), ie bundle programs or AppImages, and the latter, being a compressed format, saves disk space, making the installation really complete and... flat (sorry for the irony, but I could not resist).

### 3) "AppMan" versus Snap
- Snappy is a package manager from Canonical Ltd and the software package format is SNAP. Snappy uses a system daemon called "snapd" to work, and this slows down the system, ie the more are the installed programs, the lower is the boot speed (and the less is the RAM free), and too many times the programs are slow if compared with the same version but from the system's repositories, from Flatpak or in AppImage format;
- "AppMan" has no daemons and no hidden services are needed, each program is completely standalone and will run locally and only when you want to use it.

### 4) "AppMan" versus any other AppImage Manager
- There are many other AppImage managers around, and almost all of them support their database on appimagehub or other official AppImage resources, but the big problem is at the base of the compilation of these packages, being very often without an integrated update system. Furthermore, AppImage is a format that many developers are abandoning in favor of Flatpak, also because there were no centralized repositories or software that managed its updates in a universal way... at least until the invention of the first draft of AppMan 1.0, and therefore of its successor, "AM";
- With "AppMan" each installed program has its own script (AM-updater) that compares the installed version with the one available in the sources or uses official tools to update the AppImages ([see above](#how-to-update-all-programs-for-real)), there is support for multiple architectures (including i686 and aarch64) and anyone can create a script to install that particular program (if available for its architecture).
 
#### NOTE: the "AM" project consider AppImage not to be a priority format, but only a fallback, because if a program is already made available in a bundle by the main developer, "AppMan" will prefer it. Some examples are given by Firefox, Thunderbird, NodeJS, Blender, Chromium Latest, SuperTuxKart... they are all programs provided in bundle, no other kind of package manager is really needed for them.

-----------------------------------------------------------------------------

# Installation
To install "AppMan" quickly, just copy/paste the following command:
	
    wget https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL && chmod a+x ./INSTALL && sudo ./INSTALL

Or use "GIT":

    git clone https://github.com/ivan-hc/AppMan.git
    cd AppMan
    chmod a+x INSTALL
    sudo ./INSTALL
    
In both cases, the "INSTALL" script will create a dedicated /opt/am directory containing the ["appman"](https://github.com/ivan-hc/AM-application-manager/blob/main/appman) script (ie "AppMan" itself), a symlink for it in /usr/local/bin named `appman` and the /opt/appman/remove script needed to [uninstall](#uninstall) "AppMan" itself, if needed. A temporary folder named /opt/am/.cache will be created too, in wich each installation script or list of available applications (for your architecture) is downloaded.

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
  `--disable-completion` Removes the /etc/bash_completion.d/am-completion.sh script previously created with the "[sudo] appman --enable-completion" command:
  
    [sudo] appman --disable-completion
-----------------------------------------------------------------------------
  `--enable-completion` Create a bash completion script in /etc/bash_completion.d to complete a keyword with the TAB key using the names of all installable applications in the "AppMan" repository:
  
    [sudo] appman --enable-completion
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
"AppMan" has its inbuilt bash completion script that can be enabled using the following command (as root):

    sudo appman --enable-completion
This will ceate a bash completion script in /etc/bash_completion.d named `am-completion.sh` needed to complete a keyword with the TAB key using the names of all the main options and the name of the scripts of all the applications available in the "AM" repository.
To disable bash completion (and to remove the /etc/bash_completion.d/am-completion.sh script):

    sudo appman --disable-completion
A more detailed guide on how to create your own bash completion script for your project is available [here](https://iridakos.com/programming/2018/03/01/bash-programmable-completion-tutorial).

------------------------------------------------------------------------
### Snapshots: backup your app and restore to a previous version
"AppMan" supports snapshots of all installed applications. A selected program can be copied locally into your home folder.

- option `-b` or `backup` creates the snapshot, usage:

      appman -b $PROGRAM
- option `-o` or `overwrite` allows you to roll back to a previous version of the program. Usage:

      appman -o $PROGRAM
All the snapshots are stored into an hidden `/home/$USER/.am-snapshots` folder containing other subfolders, each one has the name of the programs you've done a backup before. Each snapshot is named with the date and time you have done the backup. To restore the application to a previous version, copy/paste the name of the snapshot when the `-o` option will prompt it.

------------------------------------------------------------------------
# Create your own script
"AppMan" has a `-t` option (or `template`) with which you can get a script for "AM" only to customize according to your needs. With this option, you can quickly create scripts to download existing programs or even create AppImage or AppDir through tools such as appimagetool and pkg2appimage.

The following video shows how to create (with "AM") and test an AppImage of "Abiword" from Debian Unstable repository with a custom AppRun (option 5):

https://user-images.githubusercontent.com/88724353/150619523-a45455f6-a656-4753-93fe-aa99babc1083.mp4

The currently available templates are stored in the "AM" repository ([here](https://github.com/ivan-hc/AM-application-manager/tree/main/templates)), more will be added with the next versions of "AM".

A wiki is also available, here I will try to explain the installation script's workflow for a program to be better managed by "AM" first (and "AppMan" then), trying to use a language that is as simple and elementary as possible.

Each script is written exclusively for "AM" and is structured in such a way that even "AppMan" can modify it to manage programs locally).

We can divide the stages of an "AM" installation's process as follows:

* [Step 1: create the main directory](https://github.com/ivan-hc/AM-Application-Manager/wiki/Step-1:-create-the-main-directory) in /opt, as already suggested by the [Linux Standard Base](https://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/opt.html) (LSB);
* [Step 2: create the "remove" script](https://github.com/ivan-hc/AM-Application-Manager/wiki/Step-2:-create-the-%22remove%22-script), needed to uninstall averything (this must be the first one to be created, in order to quickly resolve any aborted/brocken installations using the `-r` option);
* [Step 3: download the program](https://github.com/ivan-hc/AM-Application-Manager/wiki/Step-3:-download-the-program) and/or compile the program (this operation varies depending on how the program is distributed);
* [Step 4: link to a $PATH](https://github.com/ivan-hc/AM-Application-Manager/wiki/Step-4:-link-to-a-$PATH) (usually `/usr/local/bin`, but also `/usr/bin`, `/usr/games` or `/usr/local/games`);
* [Step 5: the "AM updater" script](https://github.com/ivan-hc/AM-Application-Manager/wiki/Step-5:-the-%22AM-updater%22-script), which is a kind of "copy" of step "3" (see above) that may include options to recognize newer versions of the program. NOTE that if you intend to create a script for the fixed version of a program, you can also skip this step;
* [Step 6: launchers and icons](https://github.com/ivan-hc/AM-Application-Manager/wiki/Step-6:-launchers-and-icons). Note that if you intend to create a script for a command line utility, you can also skip this step;
* [Step 7: change the permissions](https://github.com/ivan-hc/AM-Application-Manager/wiki/Step-7:-permissions) in the program folder, so you can use the update function (step 5) without using "sudo" privileges
* [Step 8 (optional): your signature](https://github.com/ivan-hc/AM-Application-Manager/wiki/Step-8-(optional):-your-signature)

The most difficult step to overcome is certainly the number "3", given the great variety of methods in which authors distribute their software, while all the other steps are much easier to overcome.

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
# Related project
### My main project behind "AppMan"
- "AM" Application Manager from https://github.com/ivan-hc/AM-APPLICATION-MANAGER

##### My other projects
- arch-deployer from https://github.com/ivan-hc/Arch-Deployer
- firefox for linux scripts, at https://github.com/ivan-hc/Firefox-for-Linux-scripts

##### My forks
- pkg2appimage for 32 bit systems, at https://github.com/ivan-hc/pkg2appimage-32bit

------------------------------------------------------------------------
# Conclusions
AppMan has a somewhat bizarre history, as it was predecessor of "AM" before, which had to correct its mistakes, and a more efficient tool improved several months later, then, using the same scripts as "AM".

Having encouraged you to visit this page is already a huge achievement for me, being AppMan my really first creation on GitHub. I'm not a developer, but a simple enthusiast who in my spare time tries to learn new things and then convert them into something more useful for the community. If only I had enough time I would devote myself completely to this, but I can't. I love to stay here because I express myself this way, and this means to spend a lot of hours of my free time on the PC trying to write scripts.

If you wish, you can support me, this work and my passion with a small [donation](https://paypal.me/ivanalexhc), I will gladly appreciate it. Thank you.
