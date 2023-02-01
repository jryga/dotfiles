# Instructions

## Pull

```sh
git clone git@github.com:joshuakraitberg/dotfiles.git ~
```

## Bootstrapping for first run

```sh
# pip install pipx
pipx install dotdrop==1.10.3
pipx ensurepath
alias dotdrop='\dotdrop --cfg=$HOME/dotfiles/config.yaml'
```

## Deploy custom dotfiles

```sh
dotdrop install -aD -p home
```

## Importing new files

```sh
# Example:
dotdrop import -l absolute -p home ~/.gitconfig
```

### Install pyenv

Pre: https://github.com/pyenv/pyenv/wiki#suggested-build-environment

```sh
sudo pacman -S --needed base-devel openssl zlib xz tk
curl https://pyenv.run | bash
```

### Install FNM

```sh
curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir $XDG_DATA_HOME/fnm
```

### Install GVM

```sh
curl -fsSL https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash -s -- master $XDG_DATA_HOME
```

### Install rust

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### Install lvim

```sh
LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh)
```
