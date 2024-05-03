
# PATH
#export PATH="$HOME/.local/bin:$PATH"

# SHELL ENVIRONMENT
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="brave"
export PAGER="less"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=header,grid --line-range :500 {}' --preview-window=right:60%:wrap"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS='
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff79c6
--color=fg+:#c0caf5,bg+:#343746,hl+:#ff79c6
--color=info:#bd93f9,prompt:#6272a4,spinner:#bd93f9,pointer:#ff79c6
--color=marker:#6272a4,header:#ff79c6
'

# TAB COMPLETION
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
_comp_options+=(globdots)

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

# export TERM="xterm-256color"

alias system_rebuild="sudo nixos-rebuild switch --flake ~/.system-dotfiles"
alias system_update="sudo nix flake update ~/.system-dotfiles"

alias l="exa -lhg --icons --time-style long-iso --sort=type -L2"
alias ll="exa -lahg --icons --time-style long-iso --sort=type -L2"
alias l.="ll -d .*"

alias mkdir="mkdir -p"
alias rm="rm -i"
alias mv="mv -i"
alias ..="cd .."

alias v="nvim"
alias sv="sudo nvim"

alias ff="fastfetch"
alias fm="ranger"

alias grep="rg"
alias cat="bat"
alias bt="bluetoothctl"

alias tm="tmux"
alias tml="tmux ls"
alias tma="tmux attach -t"
alias tmk="tmux kill-session -t"
alias tmka="tmux kill-server"

alias startHyprland="dbus-run-session Hyprland";

alias ai="${HOME}/projects/node-ai/main.js shell"

alias yarn_force="${HOME}/projects/glimworks/retailer_config/yarn_all"

# FZF Ripgrep && open with editor
fzf-ripgrep-widget(){
	setopt localoptions pipefail no_aliases 2> /dev/null
	local initial_query=""
	local rg_command="rg --hidden --column --line-number --no-heading --color=always --smart-case "
	local out="$(eval "$rg_command '$initial_query'" | FZF_DEFAULT_OPTS="--bind 'change:reload:$rg_command {q}' --ansi -d : --preview='[[ \$(file --mime {1}) =~ binary ]] && echo {1} is a binary file || (bat --style=numbers --color=always --highlight-line {2} {1} || cat {1}) 2> /dev/null | head -300' --disabled --query '$initial_query' --preview-window='+{2}+3/2' --layout=reverse" $(__fzfcmd))"
	if [[ -z "$out" ]]; then
    	zle redisplay
    	return 0
	fi
	local file_name="$(echo "$out" | sed 's/:/\n/g' | awk 'NR==1{print $1}')"
	local row="$(echo "$out" | sed 's/:/\n/g' | awk 'NR==2{print $1}')"
	local col="$(echo "$out" | sed 's/:/\n/g' | awk 'NR==3{print $1}')"
	nvim +"$row" "$file_name"
	zle redisplay
}

zle -N fzf-ripgrep-widget
# bind ctrl p to fzf-ripgrep-widget
bindkey '^p' fzf-ripgrep-widget

[ -f "${HOME}/private_aliases/one" ] && source "${HOME}/private_aliases/one"

# MISC
unsetopt correct

bindkey "^[[3~" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# PROMPT
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi
