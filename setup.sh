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

install_pkg "base-devel libx11 libxinerama libxft freetype2 dmenu slock"

# Download dwm
run_cmd "git clone --depth 1 https://github.com/phamhiep2506/dwm" "Download dwm"

# Makefile
cd dwm
run_cmd "sudo make clean install" "Build dwm"
cd ..

rm -rf dwm

# Fix screen brightness
sudo usermod -a -G video $USER

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

###########################
### Install Ibus-bamboo ###
###########################

log_warning "[+] Install ibus-bamboo\n"
install_pkg "ibus go gtk3 libx11 libxtst"

# Download ibus-bamboo
run_cmd "git clone --depth 1 https://github.com/BambooEngine/ibus-bamboo" "Download ibus-bamboo"

# Build ibus-bamboo
cd ibus-bamboo
run_cmd "sudo make install" "Build ibus-bamboo"
cd ..

rm -rf ibus-bamboo

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

install_pkg "wget tar gtk2 gtk3 arc-gtk-theme arc-icon-theme"

# Install cursor theme
run_cmd "wget https://github.com/ful1e5/BreezeX_Cursor/releases/download/v2.0.0/BreezeX-Dark.tar.gz -O BreezeX-Dark.tar.gz" "Download cursor theme"
mkdir -p $HOME/.icons
run_cmd "tar -xf BreezeX-Dark.tar.gz -C $HOME/.icons" "Install cursor theme"
rm -rf BreezeX-Dark.tar.gz

# Config gtk2
cat > $HOME/.gtkrc-2.0 <<EOF
gtk-theme-name="Arc-Dark"
gtk-icon-theme-name="Arc"
gtk-cursor-theme-name="BreezeX-Dark"
EOF

# Config gtk3
mkdir -p $HOME/.config/gtk-3.0
cat > $HOME/.config/gtk-3.0/settings.ini <<EOF
[Settings]
gtk-theme-name=Arc-Dark
gtk-icon-theme-name=Arc
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
mkdir -p $HOME/.wallpapers
cp wallpapers/gruvbox_spac.jpg $HOME/.wallpapers
#feh --bg-fill wallpapers/gruvbox_spac.jpg

########################
### Install software ###
########################

log_warning "[+] Install software\n"

# Font
install_pkg "noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-jetbrains-mono"

# WebBrowser
# install_pkg "chromium"
run_cmd "scripts/install-brave.sh" "Install brave browser"

# File explorer
install_pkg "ranger gvfs thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman"

# View video & image
install_pkg "mpv yt-dlp viewnior"

# View pdf
install_pkg "zathura zathura-pdf-mupdf"
mkdir -p $HOME/.config/zathura
cat > $HOME/.config/zathura/zathurarc <<EOF
set selection-clipboard clipboard
EOF

# Screenshot
install_pkg "flameshot"

# Network
install_pkg "network-manager-applet"

# Terminal
install_pkg "alacritty"
mkdir -p $HOME/.config/alacritty
cp configs/alacritty/alacritty.yml $HOME/.config/alacritty

# Tmux
install_pkg "tmux"
cp configs/tmux/.tmux.conf $HOME

# Vim
install_pkg "gvim npm xclip ripgrep"
cp configs/vim/.vimrc $HOME

# zsh
install_pkg "zsh zsh-autosuggestions zsh-syntax-highlighting"
cp configs/zsh/.zshrc $HOME
cp configs/zsh/.zshenv $HOME
chsh -s $(which zsh)
