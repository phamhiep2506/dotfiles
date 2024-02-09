#!/bin/sh

# DWM
sudo pacman --noconfirm -S base-devel libx11 libxinerama libxft freetype2 dmenu slock
git clone --depth 1 https://github.com/phamhiep2506/dwm
cd dwm
sudo make clean install
cd ..
rm -rf dwm

# ST
sudo pacman --noconfirm -S libxft
git clone --depth 1 https://github.com/phamhiep2506/st
cd st
sudo make clean install
cd ..
rm -rf st

# Slstatus
sudo pacman --noconfirm -S pamixer
git clone --depth 1 https://github.com/phamhiep2506/slstatus
cd slstatus
sudo make clean install
cd ..
rm -rf slstatus

# Xorg
sudo pacman --noconfirm -S xorg xorg-xinit light
cp configs/x11/.xinitrc $HOME
# Fix touchpad
sudo bash -c 'cat > /etc/X11/xorg.conf.d/30-touchpad.conf <<EOF
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "ClickMethod" "clickfinger"
    Option "NaturalScrolling" "true"
EndSection
EOF'
# Fix screen brightness
sudo usermod -a -G video $USER

# Fcitx5
sudo pacman --noconfirm -S fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-unikey
sudo bash -c 'cat > /etc/environment <<EOF
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
EOF'

# Picom
sudo pacman --noconfirm -S picom

# Wallpaper
sudo pacman --noconfirm -S feh

# Font
sudo pacman --noconfirm -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-jetbrains-mono ttf-jetbrains-mono-nerd

# File explorer
sudo pacman --noconfirm -S ranger

# Video
sudo pacman --noconfirm -S mpv

# Image
sudo pacman --noconfirm -S viewnior

# Screenshot
sudo pacman --noconfirm -S flameshot

# Tmux
sudo pacman --noconfirm -S tmux
cp configs/tmux/.tmux.conf $HOME

# Neovim
sudo pacman --noconfirm -S neovim xclip ripgrep
mkdir -p $HOME/.config/nvim
cp configs/nvim/init.lua $HOME/.config/nvim
