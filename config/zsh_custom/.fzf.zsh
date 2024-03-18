# Setup fzf
# ---------
if [[ ! "$PATH" == */home/master/zsh_extensions/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/master/zsh_custom/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/master/zsh_custom/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/master/zsh_custom/fzf/shell/key-bindings.zsh"
