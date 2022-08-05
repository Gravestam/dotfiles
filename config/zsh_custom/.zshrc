
# EXTENSIONS (LOAD)
source ~/.fzf.zsh
source ~/zsh_extensions/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/zsh_extensions/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# TAB COMPLETION
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# VIM MODE
bindkey -v
export KEYTIMEOUT=1
	# Forces VIM MODE to start in normal mode (default is insert)
	# autoload -Uz add-zle-hook-widget
	# add-zle-hook-widget line-init vi-cmd-mode

# HISTORY
HISTFILE=~/.histfile
HISTCONTROL=ignoreboth
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# ALIASES
alias ssh="kitty +kitten ssh"

alias l="exa -lhg --icons --time-style long-iso --sort=type -L2"
alias ll="exa -lahg --icons --time-style long-iso --sort=type -L2"
alias l.="ll -d .*"

alias mkdir="mkdir -p"
alias rm="rm -i"
alias mv="mv -i"
alias ..="cd .."

alias pac="sudo pacman"
alias search="pac -Ss"
alias update="pac -Syu"
alias install="pac -S"
alias remove="pac -Rsn"

alias update-mirrors="sudo reflector --verbose -c 'Sweden,Germany,Denmark' -l 40 -n 20  -p https --sort rate --save /etc/pacman.d/mirrorlist"

alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias vim="nvim"
alias v="nvim"
alias gv="neovide"

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
#neofetch
