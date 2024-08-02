## "AppMan", the rootless side of "AM" to manage all your apps locally
------------------------------------------------------------------------
*"AppMan" is a package manager for AppImages and other portable GNU/Linux applications.*

*Its behavior is reminiscent of APT, PacMan and DNF, also thanks to the options very similar to those of the most famous package managers of the most used GNU/Linux distributions.*

*All "AppMan" does is download the installation scripts from the "[AM](https://github.com/ivan-hc/AM)" database and then convert them for a local installation, in your $HOME directory, following the paths you indicated when you first launch this CLI.*

### *New code is available at *[github.com/ivan-hc/AM](https://github.com/ivan-hc/AM)**
- ***For any Issue, go to https://github.com/ivan-hc/AM/issues***
- ***For any Pull Request, go to https://github.com/ivan-hc/AM/pulls***

*"AppMan" has been an active project since the second half of 2021, and was a completely standalone script, with an at times troubled history before allowing the birth of "AM".*

*But starting with version 5, released in December 2023, the "AppMan" code merged with "AM", becoming a single script, named "[APP-MANAGER](https://github.com/ivan-hc/AM/blob/main/APP-MANAGER)", with two different behaviors depending on how it is installed and/or renamed.*

***This repository is what remains of the transition***.

------------------------------------------------------------------------
### AppMan Index
*This is a partial index, dedicated only to "AppMan". To learn more about options and how-to guides (with videos), use the [***external links index***](#external-links-index) or visit [github.com/ivan-hc/AM](https://github.com/ivan-hc/AM).*

------------------------------------------------------------------------

[Differences between "AM" and "AppMan"](#differences-between-am-and-appman)

[What programs can be installed](#what-programs-can-be-installed)

[Installation](#installation)

[Uninstall](#uninstall)

[Go to "github.com/ivan-hc/AM" for more](https://github.com/ivan-hc/AM)

[Related projects](#related-projects)

------------------------------------------------------------------------
### External links index
*All the guides listed here are available at [***github.com/ivan-hc/AM***](https://github.com/ivan-hc/AM)*

------------------------------------------------------------------------
[How to update all programs, for real](https://github.com/ivan-hc/AM#how-to-update-all-programs-for-real)

[Usage (all the available options)](https://github.com/ivan-hc/AM#usage)

[Guides and tutorials](https://github.com/ivan-hc/AM#guides-and-tutorials)
- [Install applications](https://github.com/ivan-hc/AM#install-applications)
- [Install AppImages not listed in this database but available in other github repos](https://github.com/ivan-hc/AM#install-appimages-not-listed-in-this-database-but-available-in-other-github-repos)
- [List the installed applications](https://github.com/ivan-hc/AM#list-the-installed-applications)
- [List and query all the applications available on the database](https://github.com/ivan-hc/AM#list-and-query-all-the-applications-available-on-the-database)
- [Update all](https://github.com/ivan-hc/AM#update-all)
- [Backup and restore installed apps using snapshots](https://github.com/ivan-hc/AM#backup-and-restore-installed-apps-using-snapshots)
- [Remove one or more applications](https://github.com/ivan-hc/AM#remove-one-or-more-applications)
- [Convert Type2 AppImages requiring libfuse2 to Type3 AppImages](https://github.com/ivan-hc/AM#convert-type2-appimages-requiring-libfuse2-to-type3-appimages)
- [Integrate local AppImages into the menu by dragging and dropping them](https://github.com/ivan-hc/AM#integrate-local-appimages-into-the-menu-by-dragging-and-dropping-them)
  - [How to create a launcher for a local AppImage](https://github.com/ivan-hc/AM#how-to-create-a-launcher-for-a-local-appimage)
  - [How to remove the orphan launchers](https://github.com/ivan-hc/AM#how-to-remove-the-orphan-launchers)
  - [AppImages from external media](https://github.com/ivan-hc/AM#appimages-from-external-media)
- [How to use "AM" in non-privileged mode, like "AppMan"](https://github.com/ivan-hc/AM#how-to-use-am-in-non-privileged-mode-like-appman)
- [Sandbox an AppImage](https://github.com/ivan-hc/AM#sandbox-an-appimage)
  - [How to enable a sandbox](https://github.com/ivan-hc/AM#how-to-enable-a-sandbox)
  - [How to disable a sandbox](https://github.com/ivan-hc/AM#how-to-disable-a-sandbox)
  - [Sandboxing example](https://github.com/ivan-hc/AM#sandboxing-example)
  - [About Aisap sandboxing](https://github.com/ivan-hc/AM#about-aisap-sandboxing)
- [How to enable bash completion](https://github.com/ivan-hc/AM#how-to-enable-bash-completion)
- [How to update or remove apps manually](https://github.com/ivan-hc/AM#how-to-update-or-remove-apps-manually)
- [Downgrade an installed app to a previous version](https://github.com/ivan-hc/AM#downgrade-an-installed-app-to-a-previous-version)
- [Create and test your own installation script](https://github.com/ivan-hc/AM#create-and-test-your-own-installation-script)
  - [Option Zero: "AppImages"](https://github.com/ivan-hc/AM#option-zero-appimages)
  - [Option One: "build AppImages on-the-fly"](https://github.com/ivan-hc/AM#option-one-build-appimages-on-the-fly)
  - [Option Two: "Archives and other programs"](https://github.com/ivan-hc/AM#option-two-archives-and-other-programs)
  - [Option Three: "Firefox profiles"](https://github.com/ivan-hc/AM#option-three-firefox-profiles)
  - [How an installation script works](https://github.com/ivan-hc/AM#how-an-installation-script-works)
  - [How to test an installation script](https://github.com/ivan-hc/AM#how-to-test-an-installation-script)
- [Third-party databases for applications (NeoDB)](https://github.com/ivan-hc/AM#third-party-databases-for-applications-neodb)

[Troubleshooting](https://github.com/ivan-hc/AM#troubleshooting)
- [An application does not work, is old and unsupported](https://github.com/ivan-hc/AM#an-application-does-not-work-is-old-and-unsupported)
- [Cannot download or update an application](https://github.com/ivan-hc/AM#cannot-download-or-update-an-application)
- [Cannot mount and run AppImages](https://github.com/ivan-hc/AM#cannot-mount-and-run-appimages)
- [Spyware, malware and dangerous software](https://github.com/ivan-hc/AM#spyware-malware-and-dangerous-software)
- [Stop AppImage prompt to create its own launcher, desktop integration and doubled launchers](https://github.com/ivan-hc/AM#stop-appimage-prompt-to-create-its-own-launcher-desktop-integration-and-doubled-launchers)
- [The script points to "releases" instead of downloading the latest stable](https://github.com/ivan-hc/AM#the-script-points-to-releases-instead-of-downloading-the-latest-stable)
- [Wrong download link](https://github.com/ivan-hc/AM#wrong-download-link)

------------------------------------------------------------------------
# Differences between "AM" and "AppMan"
Even though the two CLI utilities share the same body, there are some substantial differences:
1. "AM" is installed system-wide (in `/opt/am`), "**AppMan**" is portable and rootless;
2. "AM" is owned by the user that have installed it, "**AppMan**" is for all users, since it works locally, everyone can have its own apps and configurations;
3. "**AppMan**" can request the root password only if you need to installa library, "AM" requires the root password only to install, remove apps, enable a sandbox for an AppImage, or enable/disable bash completion;
4. "AM" installs apps system wide, in `/opt` (see [Linux Standard Base](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s13.html)), using the following structure:
```
/opt/$PROGRAM/
/opt/$PROGRAM/$PROGRAM
/opt/$PROGRAM/AM-updater
/opt/$PROGRAM/remove
/opt/$PROGRAM/icons/$ICON-NAME
/usr/local/bin/$PROGRAM
/usr/local/share/applications/$PROGRAM-AM.desktop
```
NOTE, all installation scripts used before June 28, 2024 show launchers in /usr/share/applications with suffix "AM-" instead of the "AM.desktop" extension, like this:

```
/usr/share/applications/AM-$PROGRAM.desktop
```
From 8 July 2024 this configuration is no longer available. Reinstall the application to get the new configuration.

"**AppMan**" is more flexible, since it asks you where to install the apps in your $HOME directory. For example, suppose you want install everything in "Applicazioni" (the italian of "applications"), this is the structure of what an installation scripts installs with "AppMan" instead:
```
~/Applicazioni/$PROGRAM/
~/Applicazioni/$PROGRAM/$PROGRAM
~/Applicazioni/$PROGRAM/AM-updater
~/Applicazioni/$PROGRAM/remove
~/Applicazioni/$PROGRAM/icons/$ICON-NAME
~/.local/bin/$PROGRAM
~/.local/share/applications/$PROGRAM-AM.desktop
```
NOTE, all installation scripts used before June 28, 2024 show the launchers with suffix "AM-" instead of the "AM.desktop" extension, like this:
```
~/.local/share/applications/AM-$PROGRAM.desktop
```
From 8 July 2024 this configuration is no longer available. Reinstall the application to get the new configuration.

The configuration file for AppMan is in `~/.config/appman` and contains the path you indicated at first startup. Changing its contents will result in changing the paths for each subsequent operation carried out with "AppMan", the apps and modules stored in the old path will not be manageable.

At first startup you can indicate any directory or subdirectory you want, as long as it is in your $HOME.

------------------------------------------------------------------------

| [Install "AppMan"](#installation) | [Back to "AppMan Index"](#appman-index) |
| - | - |

------------------------------------------------------------------------
# What programs can be installed
"AM"/"AppMan" installs, removes, updates and manages only standalone programs, ie those programs that can be run from a single directory in which they are contained. The database aims to be a reference point where you can download all the AppImage packages scattered around the web, otherwise unobtainable, as you would expect from any package manager, through specific installation scripts for each application, as happens with the AUR PKGBUILDs, on Arch Linux. You can see all of them [here](https://github.com/ivan-hc/AM/tree/main/programs), divided by architecture.

NOTE that currently my work focuses on applications for [x86_64](https://github.com/ivan-hc/AM/tree/main/programs/x86_64) architecture, but it is possible to extend "AM" to all other available architectures. If you are interested, you can deliberately join this project to improve the available lists.

1. **PROGRAMS**, they are taken:
- from official sources (see Firefox, Thunderbird, Blender, NodeJS, Chromium Latest, Platform Tools...);
- extracted from official .deb/tar/zip packages;
- from the repositories and official sites of individual developers.

2. **APPIMAGES**, they are taken:
- from official sources (if the upstream developers provide them);
- from AppImage recipes to be compiled on-the-fly with [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit);
- from unofficial third-party developers, but only if an official release is not available.

3. **FIREFOX PROFILES** to run as webapps, the ones with suffix "ffwa-" in the apps list.

4. **THIRD-PARTY LIBRARIES** (see [here](https://github.com/ivan-hc/AM/blob/main/libraries/libs-list)) if they are not provided in your distribution's repositories. These are to be installed in truly exceptional cases.

You can consult basic information, links to sites and sources used through the related command `am -a $PROGRAM` or `appman -a $PROGRAM`, or visit [**portable-linux-apps.github.io/apps**](https://portable-linux-apps.github.io/apps).

------------------------------------------------------------------------

| [Back to "AppMan Index"](#appman-index) |
| - |

------------------------------------------------------------------------
# Installation
This section explains how to install "AppMan". Below are the essential dependencies:
- "`coreutils`" (contains "`cat`", "`chmod`", "`chown`"...);
- "`curl`", to check URLs;
- "`grep`", to check files;
- "`sed`", to edit/adapt installed files;
- "`wget`" to download all programs and update "AM"/"AppMan" itself.

The following are optional dependencies that some programs may require:
- "`binutils`", contains a series of basic commands, including "`ar`" which extracts .deb packages;
- "`unzip`", to extract .zip packages;
- "`tar`", to extract .tar* packages;
- "`zsync`", about 10% of AppImages depend on this to be updated.

## How to install "AppMan"
"**AppMan**" can be used in different places, being it portable.

However, to be easily used its recommended to place it in your local "$PATH", in `~/.local/bin`.

For example, "AppMan" users must install `appman` in ~/.local/bin to allow updates via [Topgrade](https://github.com/topgrade-rs/topgrade).


#### Use "AppMan" in "$PATH"
To do so, you must first enable that "$PATH":
- add `export PATH=$PATH:$(xdg-user-dir USER)/.local/bin` in the ` ~/.bashrc`
- create the directory `~/.local/bin` if it is not available

To do all this quickly, simply copy/paste the following command:
```
mkdir -p ~/.local/bin && echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc && wget https://raw.githubusercontent.com/ivan-hc/AM/main/APP-MANAGER -O ~/.local/bin/appman && chmod a+x ~/.local/bin/appman
```
#### Use "AppMan" in "Portable Mode"
"AppMan" can run in any directory you download it, copy/paste the following command to download "APP-MANAGER", rename it to `appman` and make it executable:
```
wget https://raw.githubusercontent.com/ivan-hc/AM/main/APP-MANAGER -O appman && chmod a+x ./appman
```

### Structure of the "AppMan" installation
Unlike "AM" which needs to be placed in specific locations, "AppMan" is portable. The modules and directories will be placed in the directory you chose:
- the script "appman" is wherever you want
- the directory "$HOME/path/to/your/custom/directory/.cache" (where all processes will been executed)
- the directory "$HOME/path/to/your/custom/directory/modules" (containing the .am modules for the non-core options)
- the configuration file "$HOME/.config/appman/appman-config" (the only fixed directory)

------------------------------------------------------------------------

| [Back to "AppMan Index"](#appman-index) |
| - |

------------------------------------------------------------------------
# Uninstall
To uninstall "AppMan" just remove it and the directory `$HOME/.config/appman`

Note, before you remove your CLI, use the option `-R` to remove the apps installed using the following syntax:
```
appman -R {PROGRAM1} {PROGRAM2} {PROGRAM3}...
```

to have a list of the installed programs use the option `-f` or `files` (syntax `appman -f`).

------------------------------------------------------------------------

| [Back to "AppMan Index"](#appman-index) |
| - |

------------------------------------------------------------------------
# Related projects
#### External tools and forks used in this project
- [aisap](https://github.com/mgord9518/aisap), sandboxing solutions for AppImages
- [appimagetool/go-appimage](https://github.com/probonopd/go-appimage), get rid of libfuse2 from your AppImages
- [pkg2appimage](https://github.com/AppImage/pkg2appimage), create AppImages on the fly from existing .deb packages
- [repology](https://github.com/repology), the encyclopedia of all software versions

#### My other projects
- [AppImaGen](https://github.com/ivan-hc/AppImaGen), easily create AppImages from Ubuntu PPAs or Debian using pkg2appimage and appimagetool;
- [ArchImage](https://github.com/ivan-hc/ArchImage), create AppImages for all distributions using Arch Linux packages. Powered by JuNest;
- [Firefox for Linux scripts](https://github.com/ivan-hc/Firefox-for-Linux-scripts), easily install the official releases of Firefox for Linux;
- [My AppImage packages](https://github.com/ivan-hc#my-appimage-packages) the complete list of packages managed by me and available in this database;
- [Snap2AppImage](https://github.com/ivan-hc/Snap2AppImage), try to convert Snap packages to AppImages.

------------------------------------------------------------------------

###### *You can support me and my work on [**ko-fi.com**](https://ko-fi.com/IvanAlexHC) and [**PayPal.me**](https://paypal.me/IvanAlexHC). Thank you!*

--------

*© 2020-present Ivan Alessandro Sala aka 'Ivan-HC'* - I'm here just for fun! 

------------------------------------------------------------------------

| [**ko-fi.com**](https://ko-fi.com/IvanAlexHC) | [**PayPal.me**](https://paypal.me/IvanAlexHC) | [Install "AppMan"](#installation) | [Back to "AppMan Index"](#appman-index) | [Go to "github.com/ivan-hc/AM"](https://github.com/ivan-hc/AM) |
| - | - | - | - | - |

------------------------------------------------------------------------
