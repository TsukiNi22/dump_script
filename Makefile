##
## DUMP SCRIPT PROJECT, 2024
## dump script (fedora-like / debian-like / arch-like)
## File description:
## Makefile to start sh script
##

.SILENT:

# The distribution is checked by Linux/utils.sh (fedora-like, debian-like or arch-like)
all: launch

# The whole dump runs in the window of Linux/dump.sh
launch:
	$(MAKE) --no-print-directory -C Linux

.PHONY: all launch
