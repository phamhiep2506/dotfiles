#!/usr/bin/env bash

sudo pacman -S hyprland hyprpaper hyprlock hypridle hyprsunset hyprpicker xdg-desktop-portal-hyprland waybar \
               pipewire pipewire-pulse pipewire-jack \
               rofi-wayland wl-clipboard kitty \
               noto-fonts-emoji noto-fonts-cjk \
               firefox \
               zsh lsd tmux git \
               base-devel

# display manger
sudo pacman -S ly
sudo systemctl enable ly.service

# font
curl --location https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz --output $PWD/JetBrainsMono.tar.xz
sudo mkdir -p /usr/local/share/fonts/JetBrainsMonoNF
sudo tar -xvf $PWD/JetBrainsMono.tar.xz -C /usr/local/share/fonts/JetBrainsMonoNF
rm -rf $PWD/JetBrainsMono.tar.xz
fc-cache

# unikey
sudo pacman -S fcitx5-im fcitx5-unikey
if ! $(grep -q "GTK_IM_MODULE=fcitx" /etc/environment); then
sudo tee -a /etc/environment << EOF
GTK_IM_MODULE=fcitx
EOF
fi
if ! $(grep -q "QT_IM_MODULE=fcitx" /etc/environment); then
sudo tee -a /etc/environment << EOF
QT_IM_MODULE=fcitx
EOF
fi
if ! $(grep -q "XMODIFIERS=@im=fcitx" /etc/environment); then
sudo tee -a /etc/environment << EOF
XMODIFIERS=@im=fcitx
EOF
fi

mkdir -p $HOME/.config

# hyprland
rm -rf $HOME/.config/hypr
cp -r $PWD/hypr $HOME/.config

# kitty
rm -rf $HOME/.config/kitty
cp -r $PWD/kitty $HOME/.config

# neovim
rm -rf $HOME/.config/nvim
cp -r $PWD/nvim $HOME/.config

# waybar
rm -rf $HOME/.config/waybar
cp -r $PWD/waybar $HOME/.config

# rofi
rm -rf $HOME/.config/rofi
cp -r $PWD/rofi $HOME/.config

# cursor
curl -LO https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Classic.tar.xz
mkdir -p $HOME/.local/share/icons
tar -xvf $PWD/Bibata-Modern-Classic.tar.xz -C $HOME/.local/share/icons
rm -rf $PWD/Bibata-Modern-Classic.tar.xz

# tmux
mkdir -p $HOME/.tmux/plugins
rm -rf $HOME/.config/tmux
rm -rf $HOME/.tmux/plugins/tmux-resurrect
rm -rf $HOME/.tmux/plugins/tmux-yank
git clone https://github.com/tmux-plugins/tmux-resurrect $HOME/.tmux/plugins/tmux-resurrect --depth 1
git clone https://github.com/tmux-plugins/tmux-yank $HOME/.tmux/plugins/tmux-yank --depth 1
cp -r $PWD/tmux $HOME/.config

# browser
git clone https://aur.archlinux.org/brave-bin.git $PWD/brave-bin
(cd $PWD/brave-bin && makepkg -si)
rm -rf $PWD/brave-bin

# zsh shell
mkdir -p $HOME/.zsh/plugins
rm -rf $HOME/.zsh/plugins/zsh-autosuggestions
rm -rf $HOME/.zsh/plugins/zsh-syntax-highlighting
rm -rf $HOME/.zsh/plugins/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/plugins/zsh-autosuggestions --depth 1
git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.zsh/plugins/zsh-syntax-highlighting --depth 1
git clone https://github.com/jeffreytse/zsh-vi-mode $HOME/.zsh/plugins/zsh-vi-mode --depth 1
cp $PWD/zsh/zshrc $HOME/.zshrc
chsh -s /usr/bin/zsh
