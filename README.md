## "AppMan", the rootless side of "AM" to manage all your apps locally
------------------------------------------------------------------------
*"AM"/"AppMan" is a set of scripts and modules for installing, updating, and managing AppImage packages and other portable formats, in the same way that APT manages DEBs packages, DNF the RPMs, and so on... using a large database of Shell scripts inspired by the Arch User Repository, each dedicated to an app or set of applications.*

## What is AppMan?
*AppMan is a portable version of "[AM](https://github.com/ivan-hc/AM)", limited to installing and managing apps only locally and without root privileges.*

*The command name changes, from am to appman, but the script is the same.*

*"AM" on the contrary, provides a "fixed" installation, but can install and manage apps both locally and at the system level.*

*I recommend "AM" to privileged users who want to install and manage apps at multiple levels, and "AppMan" to non-privileged users who do not have large needs.*

## What does it do?
*All "AppMan" does is download the installation scripts from the "[AM](https://github.com/ivan-hc/AM)" database and then convert them for a local installation, in your $HOME directory, following the paths you indicated when you first launch this CLI.*

## What is this repository?
*This repository is just a guide to using "AppMan", and is specific to "AppMan".*

## Where is the source code?
*The source code can be found at* ***[github.com/ivan-hc/AM](https://github.com/ivan-hc/AM)***

## Where to report a problem?
*For any Issue, go to https://github.com/ivan-hc/AM/issues*

## How to add code?
*For any Pull Request, go to https://github.com/ivan-hc/AM/pulls*

## If "AM" and "AppMan" have the same code, why a separate repository?
*"AppMan" has been an active project since the second half of 2021, and was a completely standalone script, with an at times troubled history before allowing the birth of "AM".*

*But starting with version 5, released in December 2023, the "AppMan" code merged with "AM", becoming a single script, named "[APP-MANAGER](https://github.com/ivan-hc/AM/blob/main/APP-MANAGER)", with two different behaviors depending on how it is installed and/or renamed.*

**This repository is what remains of the transition**.

------------------------------------------------------------------------
# How to install "AppMan"?
*To install "AppMan" you must first install the "core" dependencies from your package manager:*
- *"`coreutils`" (contains "`cat`", "`chmod`", "`chown`"...);*
- *"`curl`", to check URLs;*
- *"`grep`", to check files;*
- *"`sed`", to edit/adapt installed files;*
- *"`wget`" to download all programs and update "AM" itself.*

<details>
  <summary>Additionally, you may need these optional dependencies, click here.</summary>

- *"`binutils`", contains a series of basic commands, including "`ar`" which extracts .deb packages;*
- *"`less`", to read the ever-longer lists;*
- *"`unzip`", to extract .zip packages;*
- *"`tar`", to extract .tar* packages;*
- *"`torsocks`", to connect to the TOR network;*
- *"`zsync`", required by very few programs and AppImages (although it is mentioned in all installation scripts, it is often disabled because the managed .zsync files are often broken, especially for apps hosted on github.com).*

</details>


### Quick installation
*Copy/paste the following one line command to download and run the "[AM-INSTALLER](https://github.com/ivan-hc/AM/blob/main/AM-INSTALLER)" script*
```
wget -q https://raw.githubusercontent.com/ivan-hc/AM/main/AM-INSTALLER && chmod a+x ./AM-INSTALLER && ./AM-INSTALLER
```
*...below, the screenshot of what will appear.*

![Istantanea_2024-11-02_00-03-39 png](https://github.com/user-attachments/assets/7bb170da-5b17-4d36-8d86-679d477debf5)

*Type "2" to install "AppMan", or "1" to install "[AM](https://github.com/ivan-hc/AM)". Any other key will abort the installation.*

*The above script will place the command `appman` in your local "$PATH", at `~/.local/bin` (this path is the recommended one, since it allows AppMan to be updated in bulk with all other programs, using [Topgrade](https://github.com/topgrade-rs/topgrade).*

**Installation is complete!**

*Run `appman -h` or go to "**https://github.com/ivan-hc/AM/blob/main/README.md#options**" to see all the available options.*

------------------------------------------------------------------------
# How to uninstall "AppMan"?
*Since it is a portable script, you can simply remove it manually. If you used AM-INSTALLER, you simply need to remove the `$HOME/.local/bin/appman` script.*

*NOTE, it is recommended to remove apps first using the `-R` option, and then "AppMan", see also "[How are apps installed](#how-are-apps-installed)", below.*

------------------------------------------------------------------------
## Advantages of AppMan over "AM"
*"AppMan" is a portable script, you can use it anywhere you want and it will update itself on the spot. "AM" on the other hand has a fixed installation, and requires root privileges to be installed.*

*Another advantage is the fact that it can be downloaded by anyone, even non-privileged users. On the contrary "AM" belongs only to the person who installed it, having permissions to access directories in `/opt`.*

## Disadvantages of AppMan over "AM"
*"AppMan" can only install and manage local apps, while "AM" can manage both AppMan apps and install them locally or system-wide.*

*If you are a user who doesn't like using root privileges, just use "AppMan".*

### How apps are installed
*Locally installed apps can have a directory of your choice, depending on what you decided when you first started the `appman` command.*

*For example, let's say you want to create and use the `/home/USER/Applicazioni` directory, here is the structure of a locally embedded AppImage:*
```
~/Applicazioni/$PROGRAM/
~/Applicazioni/$PROGRAM/$PROGRAM
~/Applicazioni/$PROGRAM/AM-updater
~/Applicazioni/$PROGRAM/remove
~/Applicazioni/$PROGRAM/icons/$ICON-NAME
~/.local/bin/$PROGRAM
~/.local/share/applications/$PROGRAM-AM.desktop
```

### Structure of the "AppMan" installation
*Unlike "AM" which needs to be placed in specific locations, "AppMan" is portable. The modules and directories will be placed in the directory you chose:*
- *the script "appman" is wherever you want (but it is recommended to install it in `~/.local/bin`)*
- *the directory "/path/to/your/custom/directory/modules" (containing the .am modules for the non-core options)*
- *the configuration file "$HOME/.config/appman/appman-config" (the only fixed directory)*

*all processes will been executed in $HOME/.cache/appman, while application lists, keywords to use in bash/zsh completion and other files (for third party repos, betatesting, etcetera...) will be saved and updated in $HOME/.local/share/AM to be shared with "AM", if installed.*

------------------------------------------------------------------------
## Guides and tutorials (external links)
*The guides for "AM" are also applicable to AppMan, just replace the command `am` with the command `appman`.*

*By clicking the links below, you will be redirected to the pages of the "AM" repository, at [***github.com/ivan-hc/AM***](https://github.com/ivan-hc/AM)*

------------------------------------------------------------------------
- [Install applications](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/install.md)
- [Install only AppImages](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/install-appimage.md)
  - [Install and sandbox AppImages in one go](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/install-appimage.md#install-and-sandbox-appimages-in-one-go)
- [Install AppImages not listed in this database but available in other github repos](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/extra.md)
- [List the installed applications](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/files.md)
- [List and query all the applications available on the database](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/list-and-query.md)
- [Update all](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/update.md)
- [Backup and restore installed apps using snapshots](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/backup-and-overwrite.md)
- [Remove one or more applications](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/remove.md)
- [Convert Type2 AppImages requiring libfuse2 to New Generation AppImages](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/nolibfuse.md)
- [Integrate local AppImages into the menu by dragging and dropping them](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/launcher.md)
  - [How to create a launcher for a local AppImage](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/launcher.md#how-to-create-a-launcher-for-a-local-appimage)
  - [How to remove the orphan launchers](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/launcher.md#how-to-remove-the-orphan-launchers)
  - [AppImages from external media](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/launcher.md#appimages-from-external-media)
  - [Update scattered AppImages](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/launcher.md#update-scattered-appimages)
- [Sandbox an AppImage](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/sandbox.md)
  - [How to enable a sandbox](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/sandbox.md#how-to-enable-a-sandbox)
  - [How to disable a sandbox](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/sandbox.md#how-to-disable-a-sandbox)
  - [Sandboxing example](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/sandbox.md#sandboxing-example)
  - [About Aisap sandboxing](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/sandbox.md#about-aisap-sandboxing)
- [How to update or remove apps manually](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/remove.md#how-to-update-or-remove-apps-manually)
- [Downgrade an installed app to a previous version](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/downgrade.md)
- [How to use multiple versions of the same application](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/backup-and-overwrite.md#how-to-use-multiple-versions-of-the-same-application)
- [Create and test your own installation script](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/template.md)
  - [Option Zero: "AppImages"](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/template.md#option-zero-appimages)
  - [Option One: "build AppImages on-the-fly"](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/template.md#option-one-build-appimages-on-the-fly)
  - [Option Two: "Archives and other programs"](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/template.md#option-two-archives-and-other-programs)
  - [Option Three: "Firefox profiles"](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/template.md#option-three-firefox-profiles)
  - [How an installation script works](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/template.md#how-an-installation-script-works)
  - [How to test an installation script](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/template.md#how-to-test-an-installation-script)
  - [How to submit a Pull Request](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/template.md#how-to-submit-a-pull-request)
- [Third-party databases for applications (NeoDB)](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/newrepo.md)
- [BSD, freeBSD and derivative systems: configuration and troubleshooting](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/bsd.md)

[Instructions for Linux Distro Maintainers](https://github.com/ivan-hc/AM#instructions-for-linux-distro-maintainers)

[Troubleshooting](https://github.com/ivan-hc/AM#troubleshooting)
- [An application does not work, is old and unsupported](https://github.com/ivan-hc/AM/blob/main/docs/troubleshooting.md#an-application-does-not-work-is-old-and-unsupported)
- [Cannot download or update an application](https://github.com/ivan-hc/AM/blob/main/docs/troubleshooting.md#cannot-download-or-update-an-application)
- [Cannot mount and run AppImages](https://github.com/ivan-hc/AM/blob/main/docs/troubleshooting.md#cannot-mount-and-run-appimages)
- [Failed to open squashfs image](https://github.com/ivan-hc/AM/blob/main/docs/troubleshooting.md#failed-to-open-squashfs-image)
- [Spyware, malware and dangerous software](https://github.com/ivan-hc/AM/blob/main/docs/troubleshooting.md#spyware-malware-and-dangerous-software)
- [Stop AppImage prompt to create its own launcher, desktop integration and doubled launchers](https://github.com/ivan-hc/AM/blob/main/docs/troubleshooting.md#stop-appimage-prompt-to-create-its-own-launcher-desktop-integration-and-doubled-launchers)
- [The script points to "releases" instead of downloading the latest stable](https://github.com/ivan-hc/AM/blob/main/docs/troubleshooting.md#the-script-points-to-releases-instead-of-downloading-the-latest-stable)
- [Ubuntu mess](https://github.com/ivan-hc/AM/blob/main/docs/troubleshooting.md#ubuntu-mess)
- [Wrong download link](https://github.com/ivan-hc/AM/blob/main/docs/troubleshooting.md#wrong-download-link)

------------------------------------------------------------------------------------------------------------------------------------------------
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
