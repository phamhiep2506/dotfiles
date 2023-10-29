# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Tab complete
# https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Git
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr ''
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' %F{magenta}%b%u%f'

# Prompt
setopt PROMPT_SUBST
PROMPT='%B%F{red}┌[%f%F{blue}%n%f%F{red}@%f%F{green}%m%f%F{red}](%f%F{yellow}%2~%f${vcs_info_msg_0_}%F{red})%f
%F{red}└$%f%b '

# Plugins
source $HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
