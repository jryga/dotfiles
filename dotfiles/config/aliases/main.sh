#!/usr/bin/env sh

# This is the directory of this script
this=${_:-0}
dir=$(dirname "$this")
name=$(basename "$this")

# Source everything in this directory
find "$dir" -type l,f -executable | grep -v "$this" | while read f; do
  . "$f"
done
