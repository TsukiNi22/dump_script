##
## DUMP SCRIPT PROJECT, 2024
## dump script (Fedora)
## File description:
## Makefile to start sh script
##

.SILENT:

# Color definition
RED = \033[31m
RESET = \033[0m

OS := $(shell grep "^ID=" /etc/os-release | cut -d'=' -f2 | tr -d '"')

all: launch

# The whole dump runs in the window of Fedora/dump.sh
launch:
	if [ "$(OS)" = "fedora" ]; then \
		$(MAKE) --no-print-directory -C Fedora || exit 1; \
	else \
		printf "[$(RED)ERROR$(RESET)] Unsupported OS: $(OS)\n"; \
		exit 1; \
	fi

.PHONY: all launch
