#!/bin/bash

# Dossiers
IMG_DIR="$HOME/.config/fastfetch/img"
BANANA_IMG="$HOME/.config/fastfetch/banana/banana.png"

# Fichier de config
CONFIG_SAVE="$HOME/.config/fastfetch/config_save.jsonc"
CONFIG="$HOME/.config/fastfetch/config.jsonc"

# Image par défaut : aléatoire
RANDOM_IMG=$(find "$IMG_DIR" -type f | shuf -n 1)
IMG="$RANDOM_IMG"

# Gestion des arguments
for arg in "$@"; do
    case "$arg" in
        -b|--banana)
            IMG="$BANANA_IMG"
            ;;
    esac
done

# Vérification image
if [[ ! -f "$IMG" ]]; then
    echo "Erreur: can't found the given picture -> $IMG"
    exit 1
fi

# Appliquer la config
cp "$CONFIG_SAVE" "$CONFIG"
sed -i "s#IMG#$IMG#g" "$CONFIG"

# Lancer fastfetch
fastfetch
