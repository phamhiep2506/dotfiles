#!/bin/sh

YELLOW="\033[0;33m"
NC="\033[0m"

install_pkg() {
    sudo pacman --noconfirm --needed -S $1 >/dev/null 2>&1
}

run_cmd() {
    $1 >/dev/null 2>&1
}

log_warning() {
    printf "${YELLOW}$1${NC}\n"
}

###################
### Install DWM ###
###################

log_warning "Install dwm"

# Clone dwm
run_cmd "git clone https://github.com/phamhiep2506/dwm"

# Install packages
install_pkg "base-devel libx11 libxinerama libxft freetype2"

# Makefile
run_cmd "cd dwm"
run_cmd "sudo make clean install"
run_cmd "cd .."

# Fix screen brightness
run_cmd "sudo usermod -a -G video $USER"

########################
### Install Slstatus ###
########################

log_warning "Install slstatus"

# Clone slstatus
run_cmd "git clone https://github.com/phamhiep2506/slstatus"

# Install packages
install_pkg "pamixer"

# Makefile
run_cmd "cd slstatus"
run_cmd "sudo make clean install"
run_cmd "cd .."

####################
### Install Xorg ###
####################

log_warning "Install xorg"

# Install packages
install_pkg "xorg xorg-xinit light"

# Config .xinitrc
run_cmd "cp configs/x11/.xinitrc $HOME"

# Fix touchpad
run_cmd "sudo cp configs/x11/30-touchpad.conf /etc/X11/xorg.conf.d/"

#################################
### Install GTK & Icons Theme ###
#################################

log_warning "Install gtk & icons gruvbox theme"

# Install packages
install_pkg "wget tar gtk2 gtk3"

# Clone Gruvbox-GTK-Theme
run_cmd "git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme"

# Install gruvbox theme
run_cmd "mkdir -p $HOME/.themes"
run_cmd "cp -r Gruvbox-GTK-Theme/themes/Gruvbox-Dark-B $HOME/.themes"

# Clone gruvbox-plus-icon-pack
run_cmd "git clone https://github.com/SylEleuth/gruvbox-plus-icon-pack"

# Install gruvbox icons
run_cmd "mkdir -p $HOME/.icons"
run_cmd "cp -r gruvbox-plus-icon-pack/Gruvbox-Plus-Dark $HOME/.icons"

# Install cursor theme
run_cmd "wget https://github.com/ful1e5/BreezeX_Cursor/releases/download/v2.0.0/BreezeX-Dark.tar.gz -O BreezeX-Dark.tar.gz"
run_cmd "mkdir -p $HOME/.icons"
run_cmd "tar -xf BreezeX-Dark.tar.gz -C $HOME/.icons"
run_cmd "rm BreezeX-Dark.tar.gz"

# Config gtk
run_cmd "cp configs/gtk/.gtkrc-2.0 $HOME"
run_cmd "mkdir -p $HOME/.config/gtk-3.0"
run_cmd "cp -r configs/gtk/gtk-3.0 $HOME/.config"

# Config cursor
run_cmd 'echo "[Icon Theme]\nInherits=BreezeX-Dark" > $HOME/.icons/default/index.theme'

#################
### Wallpaper ###
#################

log_warning "Install wallpaper"

# Install packages
install_pkg "feh"

# Set wallpaper
run_cmd "feh --bg-fill wallpapers/gruvbox_spac.jpg"
