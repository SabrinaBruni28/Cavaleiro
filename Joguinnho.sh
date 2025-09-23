#!/bin/sh
echo -ne '\033c\033]0;Joguinnho\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Joguinnho.x86_64" "$@"
