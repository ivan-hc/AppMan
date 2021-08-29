# AppMan
AppImage Manager that works like APT or Pacman.

# How it works

AppMan uses some [precompiled scripts](https://github.com/ivan-hc/AppMan/tree/main/applications) that can download applications from their main sites or compiling them using [pkg2appimage](https://github.com/AppImage/pkg2appimage) and [appimagetool](https://github.com/AppImage/AppImageKit), just like you can do with PKGBUILDs in AUR, the final result is a ready to use AppImage with a launcher and its icon (where needed, command line tools like "wine" can be only used from the terminal) for your favourite application. The complete list is vailable [here](https://github.com/ivan-hc/AppMan/tree/main/applications).

AppMan uses [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) to update AppImages (if zsync support is available), there is also an option to clean all backup files created after each update.

# Requirement
AppMan works with:
- [appimageupdatetool](https://github.com/AppImage/AppImageUpdate) to update AppImages
- [pkg2appimage](https://github.com/AppImage/pkg2appimage) to compile *.ylm recipes
- [appimagetool](https://github.com/AppImage/AppImageKit) to convert a *.AppDir folder to AppImage

You don't need to download them, each AppImage is included in the installation script. Keep reading!

# Installation
The installer requires privileges to create an /opt/bin directory and three symlinks for each [appimage tool needed](https://github.com/ivan-hc/AppMan/tree/main/appimage-tools) directly in /usr/bin to work. Learn more by read the [INSTALL](https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL) script.

Download and run the INSTALL script:

`wget https://raw.githubusercontent.com/ivan-hc/AppMan/main/INSTALL`

`chmod a+x ./INSTALL`

`(sudo) ./INSTALL`

Now add this line at the end of your /home/$USER/.bashrc :

`export PATH=$PATH:/opt/bin`

Download the application's list (no "SUDO" privileges are needed):

`appman -s` or `appman sync`


# AppMan usage - Commands
The script I wrote calls other scripts that I placed in /opt/bin, not just for AppImages.

  Main commands:
  
  `appman | appinstall | appremove`
  
  Usage:
  
  `appman [option]`
  where option include:
  
  `-h`, `help`	    Print this message.
 
  `-c`, `clean`	  Cleans /opt/bin by removing all *zs-old backup files.
  
  `-l`, `list`	   Shows the list of apps available in the repository.
  
  `-s`, `sync`	   Updates the list of available apps.
  
  `-u`, `update`	 Update all the AppImages in /opt/bin using appimageupdate.
  
  `appinstall [application]`   Install an application.
  
  `appremove [application]`  		Removes an application and its files.
  
  
# Why not AppImaged?
[AppImaged](https://github.com/probonopd/go-appimage) is a great project, I love it as an idea... but its frustrating to have so much superfluous launchers (for example, command-line utilities), I can't rename the AppImage by removing the extension, launchers and wrong icons due to the way the developer have bundled the software are useless and sometime they can't be launched (for example Avidemux), the update daemon has never worked for me and requires an AppImage that doesn't work on my desktop environment... but the hatefull thing is an Applications folder that appears each time I want to remove it, in my home folder, also if all AppImages are stored into a different path.

Practically AppImaged contrasts with my idea of order.

I believe that a centralized repository from which installing software and manage updates is the best choice, and AppImage is a format that deserves more success than Snap and Flatpak. I hope AppMan can be its home.
