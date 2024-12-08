##
## EPITECH PROJECT, 2024
## Fedora dump script
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

all: launch

launch: clean
	\echo -e "----------------------[${MAGENTA}START-FEDORA-DUMP${RESET}]----------------------"
	\echo -e "[${BLUE}INFO${RESET}] Start the dump on fedora..."
	\make --no-print-directory -C Fedora ARG="$(ARG)" FORCE="$(FORCE)"
	\echo -e "-----------------------[${MAGENTA}END-FEDORA-DUMP${RESET}]-----------------------"

clean:
	\unset GREEN
	\unset YELLOW
	\unset BLUE
	\unset MAGENTA
	\unset CYAN
	\unset RESET

.PHONY: all
