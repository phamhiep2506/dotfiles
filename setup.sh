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
sudo make clean install >/dev/null 2>&1
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
sudo make clean install >/dev/null 2>&1
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
