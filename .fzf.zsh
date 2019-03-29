# Setup fzf
# ---------
if [[ ! "$PATH" == */home/champly/.fzf/bin* ]]; then
  export PATH="$PATH:/home/champly/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/champly/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/champly/.fzf/shell/key-bindings.zsh"

