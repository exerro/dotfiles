# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export GIT_PS1_SHOWDIRTYSTATE=true
source ~/.git-prompt.sh
red=167
blue=31
purple=98
#PS1='${debian_chroot:+($debian_chroot)}\e[46m\e[1;37m \u \e[48;5;${red}m$(__git_ps1 " %s ")\e[48;5;${blue}m \w \e[0m '
PS1='${debian_chroot:+($debian_chroot)}\[\e[48;5;${red}m\e[1;37m\] \u \[\e[46m\] \w \[\e[48;5;${purple}m$(__git_ps1 "\] %s \[")\e[0m\] '
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

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;Terminal :: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# load global custom functions
if [ -f ~/.bash_functions.sh ]; then
    source ~/.bash_functions.sh
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
