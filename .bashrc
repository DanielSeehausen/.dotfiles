# VC alias for dotfiles. git bare repo kept in .dotfiles. See ~/.README
# for usage instructions
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ctags="`brew --prefix`/bin/ctags" # TODO what do?
alias ls1='tree -L 1'
alias ls2='tree -L 2'
alias ls3='tree -L 3'
alias cdd='cd ~/Development'
alias ls='ls -a1F'
alias ll='ls -alF'

source ~/.sandbox
source ~/git-completion.bash

export PATH="$HOME/.bin:~/bin:$PATH"
export GPG_TTY=$(tty)
export EDITOR=vim

#binds #TODO what do
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

### some basic bash history options ############################################
# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize
HISTSIZE=1000
HISTFILESIZE=2000
################################################################################

### prompt settings ############################################################
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\n\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \W\a\]$PS1"
    ;;
*)
    ;;
esac
################################################################################

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


if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi




### python lyfe ################################################################

alias python='python3'
# added by Anaconda3 5.2.0 installer
export PATH="/Users/daniel/anaconda3/bin:$PATH"
. /Users/daniel/anaconda3/etc/profile.d/conda.sh
################################################################################


### todo list cli ##############################################################
alias t='~/Development/tools/todo_list_cli/todo_controller.py'
alias tadd='~/Development/tools/todo_list_cli/todo_controller.py add'
alias trem='~/Development/tools/todo_list_cli/todo_controller.py remove'
alias tlist='~/Development/tools/todo_list_cli/todo_controller.py list'
################################################################################



### TODO still use?
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

### TODO need now that is sourced at the top?
# for git auto completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$HOME/.nvm"


alias cssh='i2cssh -c'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
