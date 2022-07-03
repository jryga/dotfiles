# Instructions

## Pull
```sh
git clone git@github.com:joshuakraitberg/dotfiles.git ~
```

## Bootstrapping for first run
```sh
alias dotdrop='DOTDROP_AUTOUPDATE=no $HOME/dotfiles/dotdrop.sh --cfg=$HOME/dotfiles/config.yaml'
```

## Deply customd dotfiles
```sh
dotdrop install -aD -p home
```
