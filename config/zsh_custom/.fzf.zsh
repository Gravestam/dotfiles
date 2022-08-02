# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/zsh_extensions/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${HOME}/zsh_extensions/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${HOME}/zsh_extensions/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${HOME}/zsh_extensions/fzf/shell/key-bindings.zsh"
