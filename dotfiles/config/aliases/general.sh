#!/usr/bin/env sh

# System
alias g='git'
alias k='kubectl'
alias vim='lvim'
alias v='lvim'
alias m='make'
alias h='htop'
alias s='sudo '
alias sudo='sudo '
alias sdn='sudo shutdown -h now'
alias srn='sudo reboot'
alias hg='history 0 | grep --color=auto'
alias vv='lvim ~/.config/lvim/config.lua'
alias tt='vim ~/.tmux.conf'
alias zz="vim ~/.zshrc"
alias zp="vim ~/.zprofile"
alias rr="source ~/.zprofile"
alias pg='ps -ef | grep'
alias svim="sudo -E $(which lvim) "
alias mine='chown $USER:$USER'
alias mkroot='chown root:root'
alias nkey='ssh-keygen -t ed25519 -a 200 -C "${USER}@${HOST}"'
alias opt='sudo watch -n 1 iptables -vnL'
alias optt='sudo watch -n 1 ip6tables -vnL'
alias ls='exa'
alias ll='exa -l'
alias la='exa -laa'
alias lt='exa -laT'
alias pf='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'

# Dump lvim settings to a file
alias lvdump="lvim --headless +'lua require(\"lvim.utils\").generate_settings()' +qa && sort -o lv-settings.lua{,} && { less lv-settings.lua; \rm lv-settings.lua }"

# Check GPG works
alias gg='echo "test" | gpg --clearsign'

pycharm () {
    /opt/pycharm-community/bin/pycharm.sh > /dev/null 2>&1 $@ &
}

ggg () {
    g++ --std=c++14 -Wall -O2 $@ && pbpaste | ./a.out
}

# python
pushv () {
    # Make and activate venv for cwd
    set -x
    DEFAULT=$(python3 --version | cut -d ' ' -f 2)
    VERSION=${1:-$DEFAULT}
    BASE=$(basename "$(pwd)")
    NAME="${BASE}-${VERSION}"
    pyenv install -s "$VERSION" && {
        echo n | pyenv virtualenv "$VERSION" "$NAME" 2>/dev/null
        pyenv local "$NAME"
        pyenv activate
    }
}

popv () {
    # Remove venv for cwd
    set -x
    DEFAULT=$(python3 --version | cut -d ' ' -f 2)
    VERSION=${1:-$DEFAULT}
    BASE=$(basename "$(pwd)")
    NAME="${BASE}-${VERSION}"
    pyenv virtualenv-delete "$NAME"
    rm .python-version
}

# tmux
alias bye='tmux detach'
alias tst='if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then; tmux new-session -A -s main; else; echo "Already using TMUX"; (exit 1); fi'

# File ops
alias cp='cp -iv'
alias mv='mv -iv'
alias mkd='mkdir -pv'

## SSH
alias kcore_bk='ssh -p 2883 josh@45.77.144.138'
alias kcore='ssh -p 2883 josh@10.19.1.1'
alias dkp='ssh josh@192.168.1.2'
alias mountpi='sudo ext4fuse /dev/disk2s2 /Volumes/rpi -o allow_other'

## Docker
alias duf='docker-compose up --force-recreate'
alias dufd='docker-compose up --force-recreate -d'

## Colorize grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

## Dotdrop
alias dotdrop='\dotdrop --cfg="$DOTDROP_YAML"'
alias ddinstall='dotdrop install -aD -p home'
alias ddupdate='dotdrop install -D -p home'

ddauto () {
    (cd "$(dirname "$DOTDROP_YAML")" && git pull && ddupdate)
}
