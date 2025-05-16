#!/bin/bash

# Lancer la surveillance avec inotifywait
WATCH_DIR1=~/delivery/cpool
WATCH_DIR2=~/delivery/psu
WATCH_DIR3=~/delivery/cpe
WATCH_DIR4=~/delivery/mat
WATCH_DIR5=~/delivery/mul
WATCH_DIR6=~/delivery/aia

# Lancer la surveillance avec inotifywait sur plusieurs répertoires
inotifywait -m -e create --format '%w%f' "$WATCH_DIR1" "$WATCH_DIR2" "$WATCH_DIR3" "$WATCH_DIR4" "$WATCH_DIR5" "$WATCH_DIR6" | while read NEW_ITEM
do
    # Vérifier si le nouvel élément est un répertoire
    if [ -d "$NEW_ITEM" ]; then
        echo "Nouveau répertoire détecté : $NEW_ITEM"

        # Entrer dans le nouveau répertoire
        cd "$NEW_ITEM"

        # Si un fichier .git existe, lancer git clone
        echo "Le répertoire $NEW_ITEM contient un dépôt Git. Clonage en cours..."
        cp -r ~/delivery/template/* .
        cp -r ~/delivery/template/.github .
        cp ~/delivery/template/.gitignore .
	L_SAMPLE=$(echo "$NEW_ITEM" | sed -E 's/.*-(my|bsmy|bs)//;s/-.*//')
        find . -type f -exec sed -i "s/sample/$L_SAMPLE/g" {} +        
	HL_SAMPLE=$(echo "$L_SAMPLE" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
	find . -type f -exec sed -i "s/Sample/$HL_SAMPLE/g" {} +
	H_SAMPLE=$(echo "$L_SAMPLE" | tr '[:lower:]' '[:upper:]')
        find . -type f -exec sed -i "s/SAMPLE/$H_SAMPLE/g" {} +        
	# Revenir au répertoire précédent
	mv include/sample.h "include/$L_SAMPLE.h"
	mv src/sample.c "src/$L_SAMPLE.c"
        cd -
    fi
done
