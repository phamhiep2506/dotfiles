autoload -U compinit
compinit
zstyle ":completion:*" menu select

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ":vcs_info:git:*" check-for-changes true
zstyle ":vcs_info:git:*" unstagedstr "*"
zstyle ":vcs_info:git:*" formats "on %F{red} %b%u%f"

setopt PROMPT_SUBST
PROMPT='%B%F{green}%n%f in %F{blue}%1~%f ${vcs_info_msg_0_}
%F{green}❯%f%b '

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export EDITOR="vim"
export ANDROID_NDK_HOME="/opt/ndk"

alias ls="ls --color"

source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $HOME/.zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
