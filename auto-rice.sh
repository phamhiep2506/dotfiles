#!/bin/sh

# install packages
install_pkg() {
	sudo pacman --noconfirm --needed -S $1
}

# remove config
rm_config() {
  if [[ -e $1 || -f $1 ]]; then
    rm -rfv $1
  fi
}

# copy config
cp_config() {
  cp -av $1 $2
}

# create folder config
mkdir -p $HOME/.config

# xorg
install_pkg xorg
install_pkg xorg-xinit
rm_config $HOME/.xinitrc
cp_config $PWD/.xinitrc $HOME

# font
install_pkg ttf-jetbrains-mono
install_pkg ttf-jetbrains-mono-nerd
install_pkg noto-fonts-cjk
install_pkg noto-fonts-emoji

# bspwm
install_pkg bspwm
rm_config $HOME/.config/bspwm
cp_config $PWD/bspwm $HOME/.config

# sxhkd
install_pkg sxhkd
rm_config $HOME/.config/sxhkd
cp_config $PWD/sxhkd $HOME/.config

# terminal
install_pkg alacritty
rm_config $HOME/.config/alacritty
cp_config $PWD/alacritty $HOME/.config

# picom
install_pkg picom
rm_config $HOME/.config/picom
cp_config $PWD/picom $HOME/.config

# polybar
install_pkg polybar
rm_config $HOME/.config/polybar
cp_config $PWD/polybar $HOME/.config

# rofi
install_pkg rofi
rm_config $HOME/.config/rofi
cp_config $PWD/rofi $HOME/.config

# nitrogen
install_pkg nitrogen

# fcitx5
install_pkg fcitx5
install_pkg fcitx5-im
install_pkg fcitx5-unikey
sudo tee /etc/environment << EOF
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
EOF

# redshift
install_pkg redshift

# nm-applet
install_pkg network-manager-applet

# xbanish
read -p "Do you want to install xbanish? (y/n) " yn
case $yn in
	y)
    sudo rm -rf /opt/xbanish
    sudo git clone https://github.com/jcs/xbanish /opt/xbanish
    (cd /opt/xbanish; sudo make clean install)
    ;;
	n)
    ;;
esac

# volume
install_pkg pamixer
install_pkg pavucontrol

# add user to a group
usermod -a -G video $USER

# slock
install_pkg slock
sudo tee /etc/systemd/system/slock@.service << EOF
[Unit]
Description=Lock X session using slock for user %i
Before=sleep.target

[Service]
User=%i
Environment=DISPLAY=:0
ExecStartPre=/usr/bin/xset dpms force suspend
ExecStart=/usr/bin/slock

[Install]
WantedBy=sleep.target
EOF
sudo systemctl enable slock@$USER.service

# brave
read -p "Do you want to install brave? (y/n) " yn
case $yn in
	y)
    install_pkg curl
    install_pkg jq
    install_pkg unzip
    BRAVE_VERSION=$(curl --silent "https://api.github.com/repos/brave/brave-browser/releases/latest"  | jq -r .tag_name)
    sudo wget -O /opt/brave-browser-$(echo $BRAVE_VERSION | cut -c2-)-linux-amd64.zip https://github.com/brave/brave-browser/releases/download/$BRAVE_VERSION/brave-browser-$(echo $BRAVE_VERSION | cut -c2-)-linux-amd64.zip
    sudo rm -rf /opt/brave-browser
    sudo unzip /opt/brave-browser-$(echo $BRAVE_VERSION | cut -c2-)-linux-amd64.zip -d /opt/brave-browser
    sudo rm -rf /opt/brave-browser-$(echo $BRAVE_VERSION | cut -c2-)-linux-amd64.zip
    sudo rm -rf /usr/local/bin/brave
    sudo ln -s /opt/brave-browser/brave /usr/local/bin
    ;;
	n)
    ;;
esac

# gtk/icon
install_pkg lxappearance
install_pkg materia-gtk-theme
install_pkg breeze-gtk
install_pkg papirus-icon-theme

# neovim
install_pkg neovim
rm_config $HOME/.config/nvim
git clone https://github.com/phamhiep2506/nvim $HOME/.config/nvim

# nautilus
install_pkg thunar
install_pkg thunar-archive-plugin
install_pkg thunar-volman

# ranger
install_pkg ranger
