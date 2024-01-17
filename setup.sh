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
        log_success "OK\n"
    else
        log_error "ERROR\n"
        exit 1
    fi
}

# run_cmd <command> <title>
run_cmd() {
    log_warning "- $2..."
    $1 >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        log_success "OK\n"
    else
        log_error "ERROR\n"
        exit 1
    fi
}

####################
#### Install DWM ###
####################

log_warning "[+] Install dwm\n"

install_pkg "base-devel libx11 libxinerama libxft freetype2 dmenu slock"

# Download dwm
run_cmd "git clone --depth 1 https://github.com/phamhiep2506/dwm" "Download dwm"

# Makefile
cd dwm
run_cmd "sudo make clean install" "Build dwm"
cd ..

rm -rf dwm

###################
#### Install ST ###
###################

log_warning "[+] Install st\n"

install_pkg "libxft"

# Download dwm
run_cmd "git clone --depth 1 https://github.com/phamhiep2506/st" "Download st"

# Makefile
cd st
run_cmd "sudo make clean install" "Build st"
cd ..

rm -rf st

#########################
#### Install Slstatus ###
#########################

log_warning "[+] Install slstatus\n"

install_pkg "pamixer"

# Download slstatus
run_cmd "git clone --depth 1 https://github.com/phamhiep2506/slstatus" "Download slstatus"

# Makefile
cd slstatus
run_cmd "sudo make clean install" "Build slstatus"
cd ..

rm -rf slstatus

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

# Fix screen brightness
sudo usermod -a -G video $USER

######################
### Install Fcitx5 ###
######################

log_warning "[+] Install fcitx5\n"
install_pkg "fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-unikey"

# Config fcitx5
sudo bash -c 'cat > /etc/environment <<EOF
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
EOF'

#####################
### Set wallpaper ###
#####################

log_warning "[+] Set wallpaper\n"

install_pkg "feh"

mkdir -p $HOME/.wallpapers
cp wallpapers/gruvbox_spac.jpg $HOME/.wallpapers
cp wallpapers/arch_anime.png $HOME/.wallpapers

########################
### Install software ###
########################

log_warning "[+] Install software\n"

# Font
install_pkg "noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-jetbrains-mono ttf-jetbrains-mono-nerd"

# File explorer
install_pkg "ranger"

# Video
install_pkg "mpv"

# Image
install_pkg "viewnior"

# Screenshot
install_pkg "flameshot"

# Network
install_pkg "network-manager-applet"

# Tmux
install_pkg "tmux"
cp configs/tmux/.tmux.conf $HOME

# Neovim
install_pkg "neovim xclip ripgrep"
mkdir -p $HOME/.config/nvim
cp configs/nvim/init.lua $HOME/.config/nvim
