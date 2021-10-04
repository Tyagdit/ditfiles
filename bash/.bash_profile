# .bash_profile

# User specific environment and startup programs
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

[ ! -d $XDG_CONFIG_HOME ] && mkdir -p $XDG_CONFIG_HOME
[ ! -d $XDG_STATE_HOME ] && mkdir -p $XDG_STATE_HOME 
[ ! -d $XDG_DATA_HOME ] && mkdir -p $XDG_DATA_HOME 
[ ! -d $XDG_CACHE_HOM ] && mkdir -p $XDG_CACHE_HOME

export HISTFILE="$XDG_STATE_HOME/.bash_history"
export HISTSIZE=9000
export HISTFILESIZE=9000
export HISTCONTROL=ignoreboth

export EDITOR="nvim"

export LESSHISTFILE="$XDG_CACHE_HOME/.lesshst"

# WSL
if [ -n "$WSL_DISTRO_NAME" ]; then
    export USERPROFILE=$(wslpath "$(cmd.exe /c echo %userprofile% 2> /dev/null)")
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
