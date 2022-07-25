#!/usr/bin/env sh


# Install programs
apt_setup () {
  apt update
  apt full-upgrade -y
  apt install -y tmux mosh zsh wget curl git ripgrep htop make shfmt python3-pip python3-venv python3-is-python nvm
}


python_setup () {
  python -m pip install -U pip wheel
  pip install pipx
  python -m pipx install black
  (cd ~/.local/share && git clone https://github.com/pyenv/pyenv && cd pyenv && activate config/src && make -C src && ln -s ~/.local/share/pyenv/bin/pyenv ~/.local/bin/pyenv)
}


nvm_setup () {
  nvm install node
  nvm use node
}


rust_setup () {
  echo "1" | (curl https://sh.rustup.rs -sSf | sh)
}


dotfiles_setup () {
  # Install lunarvim: https://www.lunarvim.org/01-installing.html
  git clone https://github.com/joshuakraitberg/dotfiles ~/.local/share
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
  source ~/.local/share/dotfiles/dotfiles/common/aliases && DOTDROP_YAML='~/.local/share/dotfiles/config.yaml' ddinstall
}


main () {
  apt_setup
  python_setup
  nvm_setup
  rust_setup
  dotfiles_setup
}
