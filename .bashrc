# VC alias for dotfiles -- git bare repo kept in .dotfiles. See ~/.README
# for usage instructions
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias ls='ls -a1F'
alias ll='ls -alF'
alias tar='/usr/bin/tar'

export PATH="$HOME/.bin:~/bin:$PATH"
export GPG_TTY=$(tty)
export EDITOR=vim

source ~/git-completion.bash
source ~/.githelpers

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
export PS1="\w\n\A $ "
# current path from home, \n, HH:MM, ' $ '
# ^made to match bash-git-prompt roughly that takes over once in a git directory

# enable color support of ls and also add handy aliases
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

### todo list cli ##############################################################
alias t='~/todo-list-cli/index.py'
alias tadd='~/todo-list-cli/index.py add'
alias trem='~/todo-list-cli/index.py rem'
alias tlist='~/todo-list-cli/index.py list'
################################################################################

# git-bash-prompt command line completion. for $BASH_VERSION > 4
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# remove all local branches but master and current branch
alias gbr='git branch | egrep -v "(master|\*)" | xargs git branch -D'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# make sure fzf uses ag for vim life
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# return current vol or set if arg provided
vol () {
  if [ $# -eq 0 ]; then
    osascript -e 'output volume of (get volume settings)'
    return 1
  fi
  osascript -e "set Volume output volume $1"
}

#Add homebrew to PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

### source and expose NVM dir ##################################################
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
################################################################################

# Use bash git prompt
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  GIT_PROMPT_ONLY_IN_REPO=1
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

echo '.bashrc loaded'
