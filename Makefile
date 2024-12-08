##
## DUMP SCRIPT PROJECT, 2024
## dump script (Fedora / Ubuntu)
## File description:
## Makefile to start sh script
##

.SILENT:

# Color definition
export RED=\033[31m
export GREEN=\033[32m
export YELLOW=\033[33m
export BLUE=\033[34m
export MAGENTA=\033[35m
export CYAN=\033[36m
export RESET=\033[0m

#echo -e "[${GREEN}OK${RESET}] Script run on Fedora"
#echo -e "[${RED}ERROR${RESET}] An error occurred"
#echo -e "[${YELLOW}WARNING${RESET}] Proceed with caution"
#echo -e "[${BLUE}INFO${RESET}] Starting the process"
#echo -e "[${MAGENTA}NOTE${RESET}] Please check the logs"
#echo -e "[${CYAN}UPDATE${RESET}] System is up to date"

OS := $(shell \grep "^ID=" /etc/os-release | cut -d'=' -f2 | tr -d '"')

all: launch

launch: clean
	if [ "$(OS)" = "fedora" ]; then \
		\echo -e "----------------------[${MAGENTA}START-FEDORA-DUMP${RESET}]----------------------"; \
		\echo -e "[${BLUE}INFO${RESET}] Start the dump on fedora..."; \
		\make --no-print-directory -C Fedora ARG="$(ARG)" FORCE="$(FORCE)"; \
		\echo -e "-----------------------[${MAGENTA}END-FEDORA-DUMP${RESET}]-----------------------"; \
	elif [ "$(OS)" = "ubuntu" ]; then \
		\echo -e "----------------------[${MAGENTA}START-UBUNTU-DUMP${RESET}]----------------------"; \
		\echo -e "[${BLUE}INFO${RESET}] Start the dump on fedora..."; \
		\make --no-print-directory -C Ubuntu ARG="$(ARG)" FORCE="$(FORCE)"; \
		\echo -e "-----------------------[${MAGENTA}END-UBUNTU-DUMP${RESET}]-----------------------"; \
	else \
		echo -e "[${RED}ERROR${RESET}] Unsupported OS: $(OS)"; \
		exit 1; \
	fi		

clean:
	\unset GREEN
	\unset YELLOW
	\unset BLUE
	\unset MAGENTA
	\unset CYAN
	\unset RESET

.PHONY: all
