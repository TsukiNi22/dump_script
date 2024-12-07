#!/bin/bash

command dnf install fswebcam -y | grep -E "Le paquet|Aucune correspondance|Erreur|Installation:| gcc "
