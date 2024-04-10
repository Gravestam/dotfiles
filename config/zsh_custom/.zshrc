
# PATH
export PATH="$HOME/.local/bin:$PATH"

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

alias nf="nvim_fzf --od node_modules --od .git"

alias ai="${HOME}/projects/others/yolo-ai-cmdbot/yolo.mod.py"

ghcs() {
	FUNCNAME="$funcstack[1]"
	TARGET="shell"
	local GH_DEBUG="$GH_DEBUG"

	read -r -d '' __USAGE <<-EOF
	Wrapper around \`gh copilot suggest\` to suggest a command based on a natural language description of the desired output effort.
	Supports executing suggested commands if applicable.

	USAGE
	  $FUNCNAME [flags] <prompt>

	FLAGS
	  -d, --debug              Enable debugging
	  -h, --help               Display help usage
	  -t, --target target      Target for suggestion; must be shell, gh, git
	                           default: "$TARGET"

	EXAMPLES

	- Guided experience
	  $ $FUNCNAME

	- Git use cases
	  $ $FUNCNAME -t git "Undo the most recent local commits"
	  $ $FUNCNAME -t git "Clean up local branches"
	  $ $FUNCNAME -t git "Setup LFS for images"

	- Working with the GitHub CLI in the terminal
	  $ $FUNCNAME -t gh "Create pull request"
	  $ $FUNCNAME -t gh "List pull requests waiting for my review"
	  $ $FUNCNAME -t gh "Summarize work I have done in issues and pull requests for promotion"

	- General use cases
	  $ $FUNCNAME "Kill processes holding onto deleted files"
	  $ $FUNCNAME "Test whether there are SSL/TLS issues with github.com"
	  $ $FUNCNAME "Convert SVG to PNG and resize"
	  $ $FUNCNAME "Convert MOV to animated PNG"
	EOF

	local OPT OPTARG OPTIND
	while getopts "dht:-:" OPT; do
		if [ "$OPT" = "-" ]; then     # long option: reformulate OPT and OPTARG
			OPT="${OPTARG%%=*}"       # extract long option name
			OPTARG="${OPTARG#"$OPT"}" # extract long option argument (may be empty)
			OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
		fi

		case "$OPT" in
			debug | d)
				GH_DEBUG=api
				;;

			help | h)
				echo "$__USAGE"
				return 0
				;;

			target | t)
				TARGET="$OPTARG"
				;;
		esac
	done

	# shift so that $@, $1, etc. refer to the non-option arguments
	shift "$((OPTIND-1))"

	TMPFILE="$(mktemp -t gh-copilotXXX)"
	trap 'rm -f "$TMPFILE"' EXIT
	if GH_DEBUG="$GH_DEBUG" gh copilot suggest -t "$TARGET" "$@" --shell-out "$TMPFILE"; then
		if [ -s "$TMPFILE" ]; then
			FIXED_CMD="$(cat $TMPFILE)"
			print -s "$FIXED_CMD"
			echo
			eval "$FIXED_CMD"
		fi
	else
		return 1
	fi
}

ghce() {
	FUNCNAME="$funcstack[1]"
	local GH_DEBUG="$GH_DEBUG"

	read -r -d '' __USAGE <<-EOF
	Wrapper around \`gh copilot explain\` to explain a given input command in natural language.

	USAGE
	  $FUNCNAME [flags] <command>

	FLAGS
	  -d, --debug   Enable debugging
	  -h, --help    Display help usage

	EXAMPLES

	# View disk usage, sorted by size
	$ $FUNCNAME 'du -sh | sort -h'

	# View git repository history as text graphical representation
	$ $FUNCNAME 'git log --oneline --graph --decorate --all'

	# Remove binary objects larger than 50 megabytes from git history
	$ $FUNCNAME 'bfg --strip-blobs-bigger-than 50M'
	EOF

	local OPT OPTARG OPTIND
	while getopts "dh-:" OPT; do
		if [ "$OPT" = "-" ]; then     # long option: reformulate OPT and OPTARG
			OPT="${OPTARG%%=*}"       # extract long option name
			OPTARG="${OPTARG#"$OPT"}" # extract long option argument (may be empty)
			OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
		fi

		case "$OPT" in
			debug | d)
				GH_DEBUG=api
				;;

			help | h)
				echo "$__USAGE"
				return 0
				;;
		esac
	done

	# shift so that $@, $1, etc. refer to the non-option arguments
	shift "$((OPTIND-1))"

	GH_DEBUG="$GH_DEBUG" gh copilot explain "$@"
}

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
