#!/bin/bash
# Usage: rdm_img.sh [-b|--banana]
# Run fastfetch with a random picture of img/ (or the banana one)
set -euo pipefail

FASTFETCH_DIR="$HOME/.config/fastfetch"
IMG_DIR="$FASTFETCH_DIR/img"
BANANA_IMG="$FASTFETCH_DIR/banana/banana.png"
CONFIG_SAVE="$FASTFETCH_DIR/config_save.jsonc" # Template, 'IMG' is replaced by the picture path
CONFIG="$FASTFETCH_DIR/config.jsonc"

IMG=$(find "$IMG_DIR" -type f | shuf -n 1)
for arg in "$@"; do
    case "$arg" in
        -b|--banana) IMG="$BANANA_IMG" ;;
        *) echo "Error: unknown argument '$arg'" >&2; exit 1 ;;
    esac
done

if [[ ! -f "$IMG" ]]; then
    echo "Error: can't find the given picture -> $IMG" >&2
    exit 1
fi

sed "s#IMG#$IMG#g" "$CONFIG_SAVE" > "$CONFIG"
fastfetch
