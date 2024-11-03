#!/bin/bash

# Color definition
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESET="\e[0m"

command dnf install gcc -y | grep -E "Le paquet|Aucune correspondance|Erreur|Installation:| gcc "
command dnf install make -y | grep -E "Le paquet|Aucune correspondance|Erreur|Installation:| make "
command dnf install vim -y | grep -E "Le paquet|Aucune correspondance|Erreur|Installation:| vim "
command dnf install git -y| grep -E "Le paquet|Aucune correspondance|Erreur|Installation:| git "
command dnf install python3 -y | grep -E "Le paquet|Aucune correspondance|Erreur|Installation:| phyton3 "
