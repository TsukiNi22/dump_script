##
## DUMP SCRIPT PROJECT, 2024
## dump script (Fedora)
## File description:
## Makefile to start sh script
##

.SILENT:

# Color definition
MAGENTA = \033[35m
BLUE = \033[34m
RED = \033[31m
RESET = \033[0m

OS := $(shell grep "^ID=" /etc/os-release | cut -d'=' -f2 | tr -d '"')

all: launch

launch:
	clear
	if [ "$(OS)" = "fedora" ]; then \
		printf "🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻[$(MAGENTA)FEDORA-DUMP$(RESET)]🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻\n"; \
		printf "[$(BLUE)INFO$(RESET)] Start the dump on fedora...\n"; \
		$(MAKE) --no-print-directory -C Fedora || exit 1; \
		printf "🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺[$(MAGENTA)FEDORA-DUMP$(RESET)]🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺\n"; \
	else \
		printf "[$(RED)ERROR$(RESET)] Unsupported OS: $(OS)\n"; \
		exit 1; \
	fi

.PHONY: all launch
