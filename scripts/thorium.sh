#!/bin/sh

sudo pacman --noconfirm --needed -S wget unzip

VERSION="120.0.6099.235"

wget -q --show-progress https://github.com/Alex313031/thorium/releases/download/M$VERSION/thorium-browser_${VERSION}_amd64.zip -O $HOME/thorium-browser_${VERSION}_amd64.zip

sudo rm -rf /opt/thorium
sudo mkdir -p /opt/thorium
sudo unzip $HOME/thorium-browser_${VERSION}_amd64.zip -d /opt/thorium

sudo mkdir -p /usr/local/bin
sudo rm /usr/local/bin/thorium
sudo ln -s /opt/thorium/thorium /usr/local/bin

rm $HOME/thorium-browser_${VERSION}_amd64.zip
