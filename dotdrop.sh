#!/usr/bin/env bash

rl="readlink -f"

if ! ${rl} "${0}" >/dev/null 2>&1; then
  rl="realpath"

  if ! hash ${rl}; then
    echo "\"${rl}\" not found!" && exit 1
  fi
fi

# setup variables
py=python3.9
ver=1.8.2
venv="$(dirname "$0")/.venv"
args=("$@")
cur=$(dirname "$(${rl} "${0}")")
opwd=$(pwd)
cfg="${cur}/config.yaml"
sub="dotdrop"

# Setup venv
test -e "$venv" || {
    "$py" -m venv "$venv"
    source "$venv/bin/activate"
    pip install dotdrop==$ver
}
source "$venv/bin/activate"

# launch dotdrop
PYTHONPATH=dotdrop python3 -m dotdrop.dotdrop "${args[@]}"
ret="$?"
# pivot back
cd "${opwd}" || { echo "Directory \"${opwd}\" doesn't exist, aborting." && exit 1; }
# exit with dotdrop exit code
exit ${ret}
