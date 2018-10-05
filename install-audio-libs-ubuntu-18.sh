#!/bin/bash

# This script is for installing audio-libs and programms for audio editing
# It's for ubuntu 18.4
# Author: Joerg Sorge
# Distributed under the terms of GNU GPL version 2 or later
# Copyright (C) Joerg Sorge joergsorge at googell
# 2018-10-02

echo ""
echo "Install audio-libs...

---
This script will
- Take the current user to the group audio
- Add a ppa for mp3gain
- Install:
git pulseaudio-module-jack
audacious radiotray soundconverter
jamin patchage asunder qjackctl
ffmpeg mp3gain lame
Invada PlugIns
Calff Plugins
Nautilus scripts
RadioTray

- Adding RadioTray Autostart and DesktopEntry

"
echo "You may this script running at least on ubuntu 18.04!!!"
echo ""

read -p "Are you sure to proceed? (y/n) " -n 1
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
	echo ""
	echo "Installation aborted"
	exit
fi

echo ""
echo "Take user to the audio group"
sudo usermod -aG audio ${USER}

echo ""
echo "PPA for mp3gain..."
sudo add-apt-repository ppa:flexiondotorg/audio
sudo apt-get update

echo ""
echo "Load and install packages..."

sudo apt install \
git jackd pulseaudio-module-jack \
audacious radiotray soundconverter \
jamin patchage asunder ffmpeg qjackctl \
mp3gain lame

echo ""
echo "Invada PlugIns..."
sudo apt install invada-studio-plugins-lv2

echo ""
echo "Calf install..."
sudo apt install calf-plugins

echo ""
echo "Load and install libs for Nautilus scripts"
sudo apt-get install \
lame mp3val libid3-tools mp3gain mp3info sox ffmpeg libsox-fmt-mp3 \
curl gawk links libtranslate-bin

echo ""
echo "Load and install natilus scripts"
git clone https://github.com/xpilgrim/nautilus-scripts-audio-video.git
cd $PWD/nautilus-scripts-audio-video
sh ./install_nautilus_scripts_ubuntu_13_local.sh
cd ..
rm -rf $PWD/nautilus-scripts-audio-video

echo ""
echo "RadioTray Autostart..."
sudo apt-get install python-xdg

if [ ! -d /home/${USER}/.config/autostart ]; then
  mkdir /home/${USER}/.config/autostart
fi

bash -c "echo ""[Desktop Entry]"" > /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""Type=Application"" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""Exec=/usr/bin/radiotray"" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""Hidden=false"" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""NoDisplay=false"" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""X-GNOME-Autostart-enabled=true"" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""Name[de_DE]=RadioTray"" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""Comment[de_DE]="" >> /home/${USER}/.config/autostart/radiotray.desktop"
bash -c "echo ""Comment="" >> /home/${USER}/.config/autostart/radiotray.desktop"

echo "finito"
read -p "Press [Enter] key to finish..."
exit
