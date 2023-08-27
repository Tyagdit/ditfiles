# Abbreviations
alias l="exa -laF --group-directories-first"
alias tree="exa -laF --group-directories-first --tree --level=2"
alias lg="exa -laF --group-directories-first --git --git-ignore"
alias treeg="exa -laF --group-directories-first --git --git-ignore --tree --level=2"

alias ..="cd .."
alias mkdir="mkdir -pv"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -Iv"
alias grep="grep --color=auto"
alias ngrep="grep -nH --color=auto"
alias please="sudo !!"
alias pls="sudo !!"
alias plz="sudo !!"

alias vv="nvim $XDG_CONFIG_HOME/nvim/"
alias vb="nvim $HOME/.bashrc"
alias htop="htop --tree"
alias dock="docker"
alias dc="docker-compose"


# git
alias gdiff="git diff --name-only --diff-filter=d | xargs bat --diff"


# Python
export PYTHON_VERSION="3.10"
alias act="source venv/bin/activate"
alias py="python$PYTHON_VERSION -q"
alias python="python$PYTHON_VERSION -q"
alias pip="python$PYTHON_VERSION -m pip"


# WSL
alias open="wslview"
alias cdwin="cd $USERPROFILE/Desktop"


# Functions
mkcd() { mkdir -p -v $1; cd $1; }

0x0() {
	if [[ -n $@  ]];
	then
		curl -F"file=@$1" https://0x0.st | clip.exe
	else
		echo -e "usage: 0x0 FILE\n\nPost FILE to https://0x0.st and copy the link to windows clipboard"
	fi
}

ranger-cd() {
	# create a temp file and store the name
	tempfile="$(mktemp -t tmp.XXXXXX)"

	# run ranger and ask it to output the last path into the
	# temp file
	ranger --choosedir="$tempfile" "${@:-$(pwd)}"

	# if the temp file exists read and the content of the temp
	# file was not equal to the current path
	test -f "$tempfile" &&
	if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
		# change directory to the path in the temp file
		cd -- "$(cat "$tempfile")"
	fi
	# its not super necessary to have this line for deleting
	# the temp file since Linux should handle it on the next
	# boot
	rm -f -- "$tempfile"
}
# This binds Ctrl-O to ranger-cd:
bind '"\C-o":"ranger-cd\C-m"'
