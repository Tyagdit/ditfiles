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

# append to history instead of overwriting
shopt -s histappend

# save history every time the prompt is drawn so commands from all terminals
# are saved when multiple terminals are open
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

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
		echo "[git: ${BRANCH}]"
	else
		echo ""
	fi
}

source $XDG_DATA_HOME/kube-ps1/kube-ps1.sh
KUBE_PS1_SYMBOL_ENABLE=false
# KUBE_PS1_SYMBOL_CUSTOM=kube
KUBE_PS1_SEPARATOR=": "
KUBE_PS1_DIVIDER="|"
KUBE_PS1_PREFIX=""
KUBE_PS1_SUFFIX=""

PS1='(k8s: $(kube_ps1)) \[\033[0;35m\]`parse_git_branch` \[\033[00m\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

source <(kubectl completion bash)

[ -f $XDG_CONFIG_HOME/bash/.bash_aliases ] && source $XDG_CONFIG_HOME/bash/.bash_aliases
[ -f $XDG_CONFIG_HOME/bash/.secrets ] && source $XDG_CONFIG_HOME/bash/.secrets

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash

export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvm"
[ -f "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -f "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
