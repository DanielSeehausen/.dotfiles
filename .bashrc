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

export PATH="$HOME/.bin:~/bin:$PATH"
export GPG_TTY=$(tty)
export EDITOR=vim

source ~/git-completion.bash
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

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

### todo list cli ##############################################################
alias t='~/todo_list_cli/index.py'
alias tadd='~/todo_list_cli/index.py add'
alias trem='~/todo_list_cli/index.py rem'
alias tlist='~/todo_list_cli/index.py list'
################################################################################



if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$HOME/.nvm"


alias cssh='i2cssh -c'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
