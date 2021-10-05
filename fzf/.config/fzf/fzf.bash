# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$XDG_DATA_HOME/fzf/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$XDG_DATA_HOME/fzf/key-bindings.bash"

# Settings
# ------------
export FZF_DEFAULT_OPTS='--height 30% --layout=reverse --border --multi --info=hidden --cycle'
export FZF_DEFAULT_COMMAND='fd --hidden --no-ignore'
export FZF_COMPLETION_TRIGGER='~~'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
