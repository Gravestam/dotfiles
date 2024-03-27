
# SHELL ENVIRONMENT
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"
export PAGER="less"

# EXTENSIONS (LOAD)
source ~/.fzf.zsh
source ~/zsh_custom/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/zsh_custom/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# TAB COMPLETION
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
_comp_options+=(globdots)

# VIM MODE
# bindkey -v
# export KEYTIMEOUT=1
	# Forces VIM MODE to start in normal mode (default is insert)
	# autoload -Uz add-zle-hook-widget
	# add-zle-hook-widget line-init vi-cmd-mode

# HISTORY
HISTFILE=~/.zsh_history
HISTCONTROL=ignoreboth
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt histignorealldups
setopt sharehistory

export TERM="xterm-256color"

alias l="exa -lhg --icons --time-style long-iso --sort=type -L2"
alias ll="exa -lahg --icons --time-style long-iso --sort=type -L2"
alias l.="ll -d .*"

alias mkdir="mkdir -p"
alias rm="rm -i"
alias mv="mv -i"
alias ..="cd .."

alias update-mirrors="sudo reflector --verbose -c 'Sweden,Germany,Denmark' -l 40 -n 20  -p https --sort rate --save /etc/pacman.d/mirrorlist"

alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias v="nvim"
alias sv="sudo nvim"

alias ff="fastfetch"
alias clip="xclip -selection clipboard"
alias fm="ranger"
alias pic="nsxiv"
alias clock="tty-clock -c -C 4"
alias fixfile="sudo sed -i -e 's/\r$//'"

alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"

alias grep="rg"
alias ps="procs"
alias cat="bat"
alias bt="bluetoothctl"

alias tm="tmux"
alias tml="tmux ls"
alias tma="tmux attach -t"
alias tmk="tmux kill-session -t"
alias tmka="tmux kill-server"

[ -f "${HOME}/private_aliases/one" ] && source "${HOME}/private_aliases/one"

# MISC
unsetopt correct

bindkey "^[[3~" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# PROMPT
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# INITIAL COMMANDS
#fastfetch
