# DOTFILES README

### To create:
```bash
    git init --bare $HOME/.dotfiles
    alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    dotfiles config status.showUntrackedFiles no

    dotfiles status
    dotfiles add .vimrc
    dotfiles commit -m "Add vimrc"
    dotfiles push
```

### To replicate home directoy on new machine:
```bash
    git clone --separate-git-dir=$HOME/.dotfiles /path/to/repo $HOME/dotfiles-tmp
    cp ~/dotfiles-tmp/.gitmodules ~  # If you use Git submodules
    rm -r ~/dotfiles-tmp/
    alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
