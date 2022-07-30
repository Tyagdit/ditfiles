# Auto-completion
[[ $- == *i* ]] && source "$XDG_DATA_HOME/fzf/completion.bash" 2> /dev/null

# Key bindings
source "$XDG_DATA_HOME/fzf/key-bindings.bash"

# Settings
export FZF_DEFAULT_OPTS=" \
    --height 30% --layout=reverse --border --multi --info=hidden --cycle \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export FZF_DEFAULT_COMMAND='fd --hidden --no-ignore'
export FZF_COMPLETION_TRIGGER='~~'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
