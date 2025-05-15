#!/bin/bash

# Dossier des images
IMG_DIR="$HOME/.config/fastfetch/img"

# Sélectionner un fichier image aléatoire
RANDOM_IMG=$(find $IMG_DIR -type f | shuf -n 1)

# Mettre à jour la configuration Fastfetch
cp ~/.config/fastfetch/config_save.jsonc ~/.config/fastfetch/config.jsonc
sed -i "s#IMG#$RANDOM_IMG#g" ~/.config/fastfetch/config.jsonc

# Exécuter Fastfetch
fastfetch
