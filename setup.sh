#!/bin/sh

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
NC="\033[0m"

log_success() {
    printf "${GREEN}$1${NC}"
}

log_error() {
    printf "${RED}$1${NC}"
}

log_warning() {
    printf "${YELLOW}$1${NC}"
}

install_pkg() {
    log_warning "- Install packages $1..."
    sudo pacman --noconfirm --needed -S $1 >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        log_success "Ok\n"
    else
        log_error "Error\n"
        exit 1
    fi
}

# run_cmd <command> <title>
run_cmd() {
    log_warning "- $2..."
    $1 >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        log_success "Ok\n"
    else
        log_error "Error\n"
        exit 1
    fi
}

####################
#### Install DWM ###
####################

log_warning "[+] Install dwm\n"

install_pkg "base-devel libx11 libxinerama libxft freetype2"

# Download dwm
rm -rf dwm
run_cmd "git clone https://github.com/phamhiep2506/dwm" "Download dwm"

# Makefile
cd dwm
run_cmd "sudo make clean install" "Build dwm"
cd ..

# Fix screen brightness
sudo usermod -a -G video $USER

#########################
#### Install Slstatus ###
#########################

log_warning "[+] Install slstatus\n"

install_pkg "pamixer"

# Download slstatus
rm -rf slstatus
run_cmd "git clone https://github.com/phamhiep2506/slstatus" "Download slstatus"

# Makefile
cd slstatus
run_cmd "sudo make clean install" "Build slstatus"
cd ..

#####################
#### Install Xorg ###
#####################

log_warning "[+] Install xorg\n"

install_pkg "xorg xorg-xinit light"

# Config .xinitrc
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

#####################
### Install Picom ###
#####################

log_warning "[+] Install picom\n"

install_pkg "libgl libev pcre libx11 xcb-util-renderutil libxcb xcb-util-image libxext pixman libconfig libdbus hicolor-icon-theme"
install_pkg "mesa meson asciidoc uthash xorgproto"

rm -rf picom
run_cmd "git clone https://github.com/dccsillag/picom -b implement-window-animations" "Download picom"

# Build picom
cd picom
git submodule update --init --recursive
run_cmd "meson --buildtype=release . build" "Build picom"
run_cmd "sudo ninja -C build install" "Install picom"
cd ..

# Config picom
mkdir -p $HOME/.config/picom
cp configs/picom/picom.conf $HOME/.config/picom

###########################
### Install Ibus-bamboo ###
###########################

log_warning "[+] Install ibus-bamboo\n"

install_pkg "ibus go gtk3 libx11 libxtst"

# Download ibus-bamboo
rm -rf ibus-bamboo
run_cmd "git clone https://github.com/BambooEngine/ibus-bamboo" "Download ibus-bamboo"

# Build ibus-bamboo
cd ibus-bamboo
run_cmd "sudo make install" "Build ibus-bamboo"
cd ..

# Config ibus
sudo bash -c 'cat > /etc/environment <<EOF
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus
# Dành cho những phần mềm dựa trên qt4
QT4_IM_MODULE=ibus
# Dành cho những phần mềm dùng thư viện đồ họa clutter/OpenGL
CLUTTER_IM_MODULE=ibus
GLFW_IM_MODULE=ibus
EOF'

##################################
#### Install GTK & Icons Theme ###
##################################

log_warning "[+] Install theme\n"

install_pkg "wget tar gtk2 gtk3"

# Install gtk theme
rm -rf Gruvbox-GTK-Theme
run_cmd "git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme" "Download gtk theme"
mkdir -p $HOME/.themes
run_cmd "cp -r Gruvbox-GTK-Theme/themes/Gruvbox-Dark-B $HOME/.themes" "Install gtk theme"

# Install icon theme
rm -rf gruvbox-plus-icon-pack
run_cmd "git clone https://github.com/SylEleuth/gruvbox-plus-icon-pack" "Download icon theme"
mkdir -p $HOME/.icons
run_cmd "cp -r gruvbox-plus-icon-pack/Gruvbox-Plus-Dark $HOME/.icons" "Install icon theme"

# Install cursor theme
rm -rf BreezeX-Dark.tar.gz
run_cmd "wget https://github.com/ful1e5/BreezeX_Cursor/releases/download/v2.0.0/BreezeX-Dark.tar.gz -O BreezeX-Dark.tar.gz" "Download cursor theme"
mkdir -p $HOME/.icons
run_cmd "tar -xf BreezeX-Dark.tar.gz -C $HOME/.icons" "Install cursor theme"

# Config gtk2
cat > $HOME/.gtkrc-2.0 <<EOF
gtk-theme-name="Gruvbox-Dark-B"
gtk-icon-theme-name="Gruvbox-Plus-Dark"
gtk-cursor-theme-name="BreezeX-Dark"
EOF

# Config gtk3
mkdir -p $HOME/.config/gtk-3.0
cat > $HOME/.config/gtk-3.0/settings.ini <<EOF
[Settings]
gtk-theme-name=Gruvbox-Dark-B
gtk-icon-theme-name=Gruvbox-Plus-Dark
gtk-cursor-theme-name=BreezeX-Dark
EOF

# Config cursor
mkdir -p $HOME/.icons/default
cat > $HOME/.icons/default/index.theme <<EOF
[Icon Theme]
Inherits=BreezeX-Dark
EOF

#####################
### Set wallpaper ###
#####################

log_warning "[+] Set wallpaper\n"

install_pkg "feh"

# Set wallpaper
feh --bg-fill wallpapers/gruvbox_spac.jpg

########################
### Install software ###
########################

log_warning "[+] Install software\n"

# Font
install_pkg "noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-jetbrains-mono"

# WebBrowser
install_pkg "chromium"

# File explorer
install_pkg "ranger gvfs thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman"

# Network
install_pkg "network-manager-applet"

# Terminal
install_pkg "alacritty"
mkdir -p $HOME/.config/alacritty
cp configs/alacritty/alacritty.yml $HOME/.config/alacritty

# Tmux
install_pkg "tmux"
cp configs/tmux/.tmux.conf $HOME

# Neovim
install_pkg "neovim nodejs npm"
mkdir -p $HOME/.config/nvim
cp configs/nvim/init.vim $HOME/.config/nvim

# zsh
install_pkg "zsh"
mkdir -p $HOME/.zsh/plugins
rm -rf $HOME/.zsh/plugins/*
run_cmd "git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/plugins/zsh-autosuggestions" "Download zsh-autosuggestions"
run_cmd "git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.zsh/plugins/zsh-syntax-highlighting" "Download zsh-syntax-highlighting"
run_cmd "git clone --depth=1 https://github.com/jeffreytse/zsh-vi-mode $HOME/.zsh/plugins/zsh-vi-mode" "Download zsh-vi-mode"
cp configs/zsh/.zshrc $HOME
cp configs/zsh/.zshenv $HOME
chsh -s $(which zsh)
