## "AppMan", the rootless side of "AM" to manage all your apps locally
------------------------------------------------------------------------
*"AppMan" is a package manager for AppImages and other portable GNU/Linux applications.*

*Its behavior is reminiscent of APT, PacMan and DNF, also thanks to the options very similar to those of the most famous package managers of the most used GNU/Linux distributions.*

*All "AppMan" does is download the installation scripts from the "[AM](https://github.com/ivan-hc/AM)" database and then convert them for a local installation, in your $HOME directory, following the paths you indicated when you first launch this CLI.*

*"AppMan" has been an active project since the second half of 2021, and was a completely standalone script, with an at times troubled history before allowing the birth of "AM".*

*But starting with version 5, released in December 2023, the "AppMan" code merged with "AM", becoming a single script, named "[APP-MANAGER](https://github.com/ivan-hc/AM/blob/main/APP-MANAGER)", with two different behaviors depending on how it is installed and/or renamed.*

*This repository is what remains of the transition*:

# *New code at *[github.com/ivan-hc/AM](https://github.com/ivan-hc/AM)**

------------------------------------------------------------------------
### AppMan Index
------------------------------------------------------------------------

[Differences between "AM" and "AppMan"](#differences-between-am-and-appman)

[What programs can be installed](#what-programs-can-be-installed)

[Installation](#installation)

[Uninstall](#uninstall)

[Go to "github.com/ivan-hc/AM" for more](https://github.com/ivan-hc/AM)

[Related projects](#related-projects)

------------------------------------------------------------------------
# Differences between "AM" and "AppMan"
Even though the two users share the same body, there are some substantial differences:
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
/usr/share/applications/AM-$PROGRAM.desktop or /usr/local/share/applications/AM-$PROGRAM.desktop
```
"**AppMan**" is more flexible, since it asks you where to install the apps in your $HOME directory. For example, suppose you want install everything in "Applicazioni" (the italian of "applications"), this is the structure of what an installation scripts installs with "AppMan" instead:
```
~/Applicazioni/$PROGRAM/
~/Applicazioni/$PROGRAM/$PROGRAM
~/Applicazioni/$PROGRAM/AM-updater
~/Applicazioni/$PROGRAM/remove
~/Applicazioni/$PROGRAM/icons/$ICON-NAME
~/.local/bin/$PROGRAM
~/.local/share/applications/AM-$PROGRAM.desktop
```
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
- "`coreutils`", is usually installed by default in all distributions as it contains basic commands ("`cat`", "`chmod`", "`chown`"...);
- "`curl`", to check URLs;
- "`grep`", to check files;
- "`jq`", to handle JSON files (some scripts need to check a download URL from api.github.com);
- "`sed`", to edit/adapt installed files;
- "`wget`" to download all programs and update "AM"/"AppMan" itself;

<details>
  <summary>See also optional dependencies, click here!</summary>

#### Listed below are optional dependencies that are needed only by some programs:
- "`binutils`", contains a series of basic commands, including "`ar`" which extracts .deb packages;
- "`unzip`", to extract .zip packages;
- "`tar`", to extract .tar* packages;
- "`zsync`", about 10% of AppImages depend on this to be updated.

</details>

- [How to install "AM"](#how-to-install-am)
- [How to install "AppMan"](#how-to-install-appman)

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
mkdir -p ~/.local/bin && echo 'export PATH=$PATH:$(xdg-user-dir USER)/.local/bin' >> ~/.bashrc && wget https://raw.githubusercontent.com/ivan-hc/AM/main/APP-MANAGER -O appman && chmod a+x ./appman && mv ./appman ~/.local/bin/appman
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
- [aisap](https://github.com/mgord9518/aisap)
- [appimagetool/go-appimage](https://github.com/probonopd/go-appimage)
- [pkg2appimage](https://github.com/AppImage/pkg2appimage)

#### My other projects
- [AppImaGen](https://github.com/ivan-hc/AppImaGen), a script that generates AppImages from Debian or from a PPA for the previous Ubuntu LTS;
- [ArchImage](https://github.com/ivan-hc/ArchImage), build AppImage packages for all distributions but including Arch Linux packages. Powered by JuNest;
- [Firefox for Linux scripts](https://github.com/ivan-hc/Firefox-for-Linux-scripts), easily install the official releases of Firefox for Linux.
- [My AppImage packages](https://github.com/ivan-hc#my-appimage-packages)

------------------------------------------------------------------------

###### *You can support me and my work on [**ko-fi.com**](https://ko-fi.com/IvanAlexHC) and [**PayPal.me**](https://paypal.me/IvanAlexHC). Thank you!*

--------

*© 2020-present Ivan Alessandro Sala aka 'Ivan-HC'* - I'm here just for fun! 

------------------------------------------------------------------------

| [**ko-fi.com**](https://ko-fi.com/IvanAlexHC) | [**PayPal.me**](https://paypal.me/IvanAlexHC) | [Install "AppMan"](#installation) | [Visit "ivan-hc/AM"](https://github.com/ivan-hc/AM) |
| - | - | - | - |

------------------------------------------------------------------------
