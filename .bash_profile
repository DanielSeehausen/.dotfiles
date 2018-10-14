# Daniel Seehausen bash profile
# Apart from several minor changes, the profile supports git display on the
# prompt (status/branch/etc.), which requires: ~/.bash-git-prompt/gitprompt.sh
# IF USING THIS ELSEWHERE - TAKE THE FOLLOWING WITH YOU:
#   .bash-git-prompt

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

# this will print out two levels deep for the prompt
function PWD {
  pwd | awk -F\/ '{print $(NF-1),$(NF)}' | sed "s/ /\\//"
}
#
# parse_git_branch() {
#     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u: \[\033[33m\]\$(PWD)\[\033[0m\]\[\033[32m\] $\[\033[00m\] "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\n\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \W\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias ls='ls -Fa'
#this part for linux
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#binds
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

alias c='atom ~/Development/curriculum'

alias python='python3'
alias flashcards='~/Development/tools/todo_list_cli.py'
alias todos='~/Development/tools/todo_list_cli/todo_controller.py'
alias t='~/Development/tools/todo_list_cli/todo_controller.py'
alias tadd='~/Development/tools/todo_list_cli/todo_controller.py add'
alias trem='~/Development/tools/todo_list_cli/todo_controller.py remove'
alias tlist='~/Development/tools/todo_list_cli/todo_controller.py list'

alias ls1='tree -L 1'
alias ls2='tree -L 2'
alias ls3='tree -L 3'
alias cdd='cd ~/Development'
alias cdh='cd ~'
alias ls='ls -a1F'
alias ll='ls -alF'

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

#some helpers/tool around space for bash scripts mostly templates its a mess don't look
source ~/.doge-functions.sh

alias ..='cd ..'
alias gac="git add . && git commit -m ${1}"
gacp () { git add . && git commit -m "$@" && git push; }
gbco () { git branch $@ && git co $@; }

lc () {
  git clone https://github.com/learn-co-curriculum/$1
  cd $1
  gitgimme
}

# for git auto completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$HOME/.nvm"

# alias gitopen="open https://github.$(git config remote.origin.url | cut -f2 -d.)"
alias gb='git branch'
alias remove-spaces='for f in *\ *; do mv "$f" "${f// /-}"; done'

learn-create () {
  mkdir $1
  cd $1
  git init
  bash <(curl -s https://raw.githubusercontent.com/learn-co-curriculum/curriculum-team/master/new-learn-repository.sh?token=AQS7rUzyXk_UaYBqRQzsmS_Rk-0dRScRks5bSkD-wA%3D%3D)
  hub create learn-co-curriculum/${PWD##*/}
  git remote add origin https://github.com/learn-co-curriculum/${PWD##*/}.git
  git add .
  git commit -m 'initial commit with learn-create'
  if git push
  then
    echo "git push succeeded"
  else
    echo "push failed, attempting --set-upstream"
    if git push --set-upstream origin master
    then
      echo "...pushed!"
    else
      echo "push to remote origin failed!"
    fi
  fi
}

git() {
    if [[ $@ == "log" ]]; then
        command git log --pretty=oneline
    else
        command git "$@"
    fi
}

source ~/git-completion.bash

alias cssh='i2cssh -c'
export EDITOR=vim

# added by Anaconda3 5.2.0 installer
export PATH="/Users/daniel/anaconda3/bin:$PATH"
. /Users/daniel/anaconda3/etc/profile.d/conda.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
alias ltest='/Users/daniel/Development/pytest-addition/learn-co/ruby/2.5.0/gems/learn-test-2.5.6/bin/learn-test'
