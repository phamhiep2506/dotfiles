#!/usr/bin/env bash

# font
curl https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz -o $PWD/JetBrainsMono.tar.xz
sudo mkdir -p /usr/local/share/fonts/JetBrainsMonoNF
sudo tar -xvf $PWD/JetBrainsMono.tar.xz -C /usr/local/share/fonts/JetBrainsMonoNF
rm -rf $PWD/JetBrainsMono.tar.xz
fc-cache

# tmux
mkdir -p $HOME/.tmux/plugins
git clone https://github.com/tmux-plugins/tmux-resurrect $HOME/.tmux/plugins/tmux-resurrect --depth 1
git clone https://github.com/tmux-plugins/tmux-yank $HOME/.tmux/plugins/tmux-yank --depth 1

# zsh
mkdir -p $HOME/.zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/plugins/zsh-autosuggestions --depth 1
git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.zsh/plugins/zsh-syntax-highlighting --depth 1
git clone https://github.com/jeffreytse/zsh-vi-mode $HOME/.zsh/plugins/zsh-vi-mode --depth 1

# vim
mkdir -p $HOME/.vim/pack/default/start
git clone https://github.com/morhetz/gruvbox $HOME/.vim/pack/default/start/gruvbox --depth 1
git clone https://github.com/tpope/vim-sensible $HOME/.vim/pack/default/start/vim-sensible --depth 1
git clone https://github.com/tpope/vim-sleuth $HOME/.vim/pack/default/start/vim-sleuth --depth 1
git clone https://github.com/tpope/vim-commentary $HOME/.vim/pack/default/start/vim-commentary --depth 1
git clone https://github.com/tpope/vim-surround $HOME/.vim/pack/default/start/vim-surround --depth 1
git clone https://github.com/tpope/vim-repeat $HOME/.vim/pack/default/start/vim-repeat --depth 1
git clone https://github.com/ntpeters/vim-better-whitespace $HOME/.vim/pack/default/start/vim-better-whitespace --depth 1
