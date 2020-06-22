# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export GIT_PS1_SHOWDIRTYSTATE=true
source ~/.git-prompt.sh
red=167
blue=31
purple=98
#PS1='${debian_chroot:+($debian_chroot)}\e[46m\e[1;37m \u \e[48;5;${red}m$(__git_ps1 " %s ")\e[48;5;${blue}m \w \e[0m '
PS1='${debian_chroot:+($debian_chroot)}\[\e[48;5;${red}m\e[1;37m\] \u \[\e[46m\] \w \[\e[48;5;${purple}m$(__git_ps1 "\] %s \[")\e[0m\] → '
PS1='\[\e[1;31m\] \u \[\e[1;30m\]>\[\e[1;36m\] \w $(__git_ps1 "\[\e[1;30m\]>\[\e[38;5;98m\] %s ")\[\e[0m\]\n → '
PS1="\033]0;\w\007$PS1" # set title
# PS2='${debian_chroot:+($debian_chroot)}\[\e[01;32m\]\u\[\e[1;34m\] \w\[\e[0;37m\] \[\e[38;2m\]$\[\e[0m\] '
PS2='\e[48;5;${red}mthis is PS2, fix it\e[0m'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# enable color support of ls and also add handy aliases
LS_COLORS="di=40;33 : ex=4;36;1 : fi=36;1 : ln=40;32 : mi=1;40;30 : or=1;40;30"
LS_COLORS="$LS_COLORS : ow=40;33 : st=40;33 : tw=40;33"
LS_COLORS="$LS_COLORS : no=0 : bd=1;41;30 : cd=1;41;30 : do=1;41;30 : pi=1;41;30 : sg=1;41;30 : so=1;41;30 : st=1;41;30 : su=1;41;30"
export LS_COLORS=$(printf "$LS_COLORS" | tr -d ' ')

# di - Directory
# ex - Executable file (ie. has 'x' set in permissions)
# fi - Normal file
# ln - Symbolic link. If you set this to ‘target’ instead of a numerical value, the color is as for the file pointed to.
# mi - Non-existent file pointed to by a symbolic link (visible when you type ls -l)
# or - Symbolic link pointing to an orphaned non-existent file

# ow - Directory that is other-writable (o+w) and not sticky
# st - Directory with the sticky bit set (+t) and not other-writable
# tw - Directory that is sticky and other-writable (+t,o+w)

# no - Normal (non-filename) text. Global default, although everything should be something
# bd - Block device (buffered) special file
# cd - Character device (unbuffered) special file
# do - [Door][1]
# pi - Named pipe (fifo file)
# sg - File that is setgid (g+s)
# so - Socket file
# su - File that is setuid (u+s)

# *.extension =   Every file using this extension e.g. *.rpm = files with the ending .rpm

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# load global custom functions
if [ -f ~/.bash_functions.sh ]; then
    source ~/.bash_functions.sh
    title $(pwd)
fi

# load global custom aliases
if [ -f ~/.bash_aliases.sh ]; then
    source ~/.bash_aliases.sh
fi

# load local custom functions
if [ -f .bash_functions.sh ]; then
    source .bash_functions.sh
fi

# load local custom functions
if [ -f .bash_aliases.sh ]; then
    source .bash_aliases.sh
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
