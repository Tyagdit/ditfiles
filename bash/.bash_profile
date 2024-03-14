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
export HISTFILESIZE=90000
export HISTCONTROL=ignoreboth

export EDITOR="nvim"
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export BAT_THEME="Dracula"

export LESSHISTFILE="$XDG_CACHE_HOME/.lesshst"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

export PATH="$PATH:/usr/local/go/bin:$XDG_DATA_HOME/go/bin"
export GOPATH="$XDG_DATA_HOME/go"

# WSL
if [ -n "$WSL_DISTRO_NAME" ]; then
    # export USERPROFILE=$(wslpath "$(cmd.exe /c echo %userprofile% 2> /dev/null)")
    export USERPROFILE="/mnt/c/Users/Aditya\ Desigar"

    export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
    export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH="/mnt/c/Users/Aditya Desigar"
    export VAGRANT_WSL_DISABLE_VAGRANT_HOME="1"
    export VAGRANT_HOME="/mnt/c/Users/Aditya Desigar/vagrant"
    export VAGRANT_DEFAULT_PROVIDER="hyperv"

    # set the path to check docker binary in Rancher Desktop's installation before Docker Desktop's
    export PATH="/mnt/c/Program Files/Rancher Desktop/resources/resources/linux/bin/:/mnt/c/Program Files/Docker/Docker/resources/bin:$PATH"
fi

export KREW_ROOT="$XDG_STATE_HOME/krew"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
