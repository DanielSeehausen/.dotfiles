
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

export PATH="$HOME/.bin:~/bin:$PATH"

export GPG_TTY=$(tty)
alias ctags="`brew --prefix`/bin/ctags"
eval export

alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
export EDITOR='vim'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
