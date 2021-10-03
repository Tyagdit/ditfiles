# .bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

function parse_git_branch {
	BRANCH=`git branch --show-current 2> /dev/null`
	if [ ! "${BRANCH}" == "" ]
	then
		echo "[${BRANCH}]"
	else
		echo ""
	fi
}

PS1='\[\033[0;35m\]`parse_git_branch`\[\033[00m\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# shift + arrows to go back and forth one word at a time
bind '"\e[1;2D": backward-word'
bind '"\e[1;2C": forward-word'

# User specific aliases and functions
[ -f $XDG_CONFIG_HOME/bash/.bash_aliases ] && source $XDG_CONFIG_HOME/bash/.bash_aliases
[ -f $XDG_CONFIG_HOME/bash/.secrets ] && source $XDG_CONFIG_HOME/bash/.secrets
