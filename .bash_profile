# .bash_profile is executed for login shells, while .bashrc is executed for interactive non-login shells.
# On OS X, Terminal by default runs a login shell every time
if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi
