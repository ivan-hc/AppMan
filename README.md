## "AppMan", the rootless side of "AM" to manage all your portable apps locally

***NOTE: This repository is a just a guide to using the "AM" package manager without root privileges.***

***Before reading further, please visit the "AM" repository, at https://github.com/ivan-hc/AM, to better understand AppMan and how it works.***

[![Istantanea_2024-06-26_17-00-46 png](https://github.com/ivan-hc/AM/assets/88724353/671f5eb0-6fb6-4392-b45e-af0ea9271d9b)](https://github.com/ivan-hc/AM)

[![Readme](https://img.shields.io/github/stars/ivan-hc/AM?label=%E2%AD%90&style=for-the-badge)](https://github.com/ivan-hc/AM/stargazers) [![Readme](https://img.shields.io/github/license/ivan-hc/AM?label=&style=for-the-badge)](https://github.com/ivan-hc/AM/blob/main/LICENSE)

*Otherwise use this index to navigate this README.*

------------------------------------------------------------------------
### Index
------------------------------------------------------------------------

- [What is AppMan?](#what-is-appman)
- [What does it do?](#what-does-it-do)
- [What is this repository?](#what-is-this-repository)
- [Where is the source code?](#where-is-the-source-code)
- [Where to report a problem?](#where-to-report-a-problem)
- [How to add code?](#how-to-add-code)
- [If "AM" and "AppMan" have the same code, why a separate repository?](#if-am-and-appman-have-the-same-code-why-a-separate-repository)
- [How to install "AppMan"?](#how-to-install-appman)
  - [How to uninstall "AppMan"?](#how-to-uninstall-appman)
- [Advantages of AppMan over "AM"](#advantages-of-appman-over-am)
- [Disadvantages of AppMan over "AM"](#disadvantages-of-appman-over-am)
- [How apps are installed](#how-apps-are-installed)
- [Structure of the "AppMan" installation](#structure-of-the-appman-installation)
- [Guides and tutorials (external links)](#guides-and-tutorials-external-links)
- [Related projects](#related-projects)

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
- *"`zsync`", required by very few programs.*

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
#### How to install AppMan manually
<details>
  <summary>Click here to expand</summary>
As we've already seen, AppMan is portable, meaning you can use it anywhere, in any directory with read and write permissions.

The basic principle is very simple: the APP-MANAGER script must be renamed "appman".

Try it and believe it:
```
wget -q "https://raw.githubusercontent.com/ivan-hc/AM/main/APP-MANAGER" -O ./appman && chmod a+x ./appman
```
However, **this approach is NOT RECOMMENDED** for various reasons, the most common being convenience:
- the AM-INSTALLER ensures the creation of an XDG_BIN_HOME or $HOME/.local/bin directory if it doesn't already exist, so you can use it in $PATH without having to write the entire path to the script.
- by installing it in the local $PATH, the AM-INSTALLER also takes care of its use in ZSH, if that is used instead of BASH.

To install it into $PATH manually, run the following commands:
```
ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"
BINDIR="${XDG_BIN_HOME:-$HOME/.local/bin}"
mkdir -p "$BINDIR"
if ! echo $PATH | grep "$BINDIR" >/dev/null 2>&1; then 
	if [ -e ~/.bashrc ] && ! grep 'PATH="$PATH:$BINDIR"' ~/.bashrc >/dev/null 2>&1; then
		printf '\n%s\n' 'BINDIR="${XDG_BIN_HOME:-$HOME/.local/bin}"' >> ~/.bashrc
		printf '\n%s\n' 'if ! echo $PATH | grep "$BINDIR" >/dev/null 2>&1; then' >> ~/.bashrc
		printf '	export PATH="$PATH:$BINDIR"\nfi\n' >> ~/.bashrc
	fi
	if [ -e "$ZSHRC" ] && ! grep 'PATH="$PATH:$BINDIR"' "$ZSHRC" >/dev/null 2>&1; then
		printf '\n%s\n' 'BINDIR="${XDG_BIN_HOME:-$HOME/.local/bin}"' >> "$ZSHRC"
		printf '\n%s\n' 'if ! echo $PATH | grep "$BINDIR" >/dev/null 2>&1; then' >> "$ZSHRC"
		printf '	export PATH="$PATH:$BINDIR"\nfi\n' >> "$ZSHRC"
	fi
fi
wget -q "https://raw.githubusercontent.com/ivan-hc/AM/$AM_BRANCH/APP-MANAGER" -O "$BINDIR"/appman && chmod a+x "$BINDIR"/appman
```
The above is a "summary" (without the messages) of what the AM-INSTALLER script already does when you choose option 2 (AppMan).

For more information, see https://github.com/ivan-hc/AM/issues/1830

</details>

------------------------------------------------------------------------
# How to uninstall "AppMan"?
*Since it is a portable script, you can simply remove it manually. If you used AM-INSTALLER, you simply need to remove the `$HOME/.local/bin/appman` script.*

*NOTE, it is recommended to remove apps first using the `-R` option, and then "AppMan", see also "[How are apps installed](#how-apps-are-installed)", below.*

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
- [Clone a set of programs installed from other AM and AppMan configurations](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/clone.md)
- [Change the destination path of installed programs](https://github.com/ivan-hc/AM/blob/main/docs/guides-and-tutorials/relocate.md)
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
#### Side Projects
- *[amcheck](https://github.com/ivan-hc/amcheck), checks the validity of scripts in this database and monitors the availability of AppImages*
- *[am-extras](https://github.com/ivan-hc/am-extras), lists applications from third-party databases*

#### External tools and forks used in this project
- *[aisap](https://github.com/mgord9518/aisap) and [sas](https://github.com/Samueru-sama/simple-appimage-sandbox), sandboxing solutions for AppImages, see sandboxing options above*
- *[appimagetool](https://github.com/AppImage/appimagetool), get rid of libfuse2 from old AppImages (option `nolibfuse`) and create AppImages on the fly (see [appimage-bulder-scripts](https://github.com/ivan-hc/AM/tree/main/appimage-bulder-scripts))*
- *[dbin](https://github.com/xplshn/dbin), the easy to use/get, suckless software distribution system, used as OCI registry client to install packages from third-party databases*

#### Organizations and their affiliates that actively contribute to this project
- *[Package Forge](https://github.com/pkgforge), Improving Package Management & Security for Linux systems*
  - *[Dev](https://github.com/pkgforge-dev), Package Forge's Official Developer Repos*
  - *[Community](https://github.com/pkgforge-community), Package Forge's Community Repos, Projects & their Dependencies*
- *[Portable Linux Apps](https://github.com/Portable-Linux-Apps), Census, cataloging and distribution of AppImages and portable apps for GNU/Linux*

#### My other projects
- *[AppImaGen](https://github.com/ivan-hc/AppImaGen), easily create AppImages from Ubuntu PPAs or Debian using pkg2appimage and appimagetool*
- *[ArchImage](https://github.com/ivan-hc/ArchImage), create AppImages for all distributions using Arch Linux packages. Powered by JuNest*
- *[Firefox for Linux scripts](https://github.com/ivan-hc/Firefox-for-Linux-scripts), easily install the official releases of Firefox for Linux*
- *[My AppImage packages](https://github.com/ivan-hc#my-appimage-packages) the complete list of packages managed by me and available in this database*
- *[Snap2AppImage](https://github.com/ivan-hc/Snap2AppImage), try to convert Snap packages to AppImages*

------------------------------------------------------------------------

###### *You can support me and my work on [**ko-fi.com**](https://ko-fi.com/IvanAlexHC) and [**PayPal.me**](https://paypal.me/IvanAlexHC). Thank you!*

--------

*© 2020-present Ivan Alessandro Sala aka 'Ivan-HC'* - I'm here just for fun! 

------------------------------------------------------------------------

| [**ko-fi.com**](https://ko-fi.com/IvanAlexHC) | [**PayPal.me**](https://paypal.me/IvanAlexHC) | [Go to "github.com/ivan-hc/AM"](https://github.com/ivan-hc/AM) |
| - | - | - |

------------------------------------------------------------------------
