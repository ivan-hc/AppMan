#!/bin/sh

cd /opt/bin
wget https://github.com/OpenShot/openshot-qt/releases/download/v2.6.0/OpenShot-v2.6.0-x86_64.AppImage;
mv ./OpenShot-v2.6.0-x86_64.AppImage ./openshot;
chmod a+x ./openshot;
echo '[Desktop Entry]
Name=OpenShot Video Editor
GenericName=Video Editor
X-GNOME-FullName=OpenShot Video Editor
Comment=Create and edit amazing videos and movies
Exec=/opt/bin/openshot %F
Terminal=false
Type=Application
Icon=openshot
Categories=GNOME;GTK;AudioVideo;Video;AudioVideoEditing;
MimeType=application/vnd.openshot-qt-project;
X-AppInstall-Package=openshot-qt
Path=
StartupNotify=true' >> /home/$USER/.local/share/applications/openshot.desktop;
wget https://github.com/ivan-hc/AppMan/tree/main/applications/openshot/openshot.svg;
mv ./openshot.svg /home/$USER/.local/share/icons/
