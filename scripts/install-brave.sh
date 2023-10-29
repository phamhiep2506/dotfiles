#!/bin/sh

sudo pacman --noconfirm --needed -S curl wget unzip

VERSION=$(curl -s https://brave-browser-downloads.s3.brave.com/latest/release-linux-x64.version)

wget -q --show-progress https://github.com/brave/brave-browser/releases/download/v$VERSION/brave-browser-$VERSION-linux-amd64.zip -O $HOME/brave-browser-$VERSION-linux-amd64.zip

sudo rm -rf /opt/brave
sudo mkdir -p /opt/brave
sudo unzip $HOME/brave-browser-$VERSION-linux-amd64.zip -d /opt/brave

sudo mkdir -p /usr/local/bin
sudo rm /usr/local/bin/brave
sudo ln -s /opt/brave/brave /usr/local/bin

rm $HOME/brave-browser-$VERSION-linux-amd64.zip
