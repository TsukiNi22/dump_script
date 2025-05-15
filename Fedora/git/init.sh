echo -e "[${GREEN}OK${RESET}] Configuration of the git information"

if [ -d ~/personal_delivery/ ]; then
    echo -e "[${GREEN}OK${RESET}] Personal delivery already setup"
else
    command mkdir -p ~/personal_delivery/
    command cd ~/personal_delivery/
    command git init
    command cd -
    echo -e "[${GREEN}OK${RESET}] Setup personal delivery"
fi
if [ -d ~/delivery/ ]; then
    echo -e "[${GREEN}OK${RESET}] Work delivery already setup"
else
    command mkdir -p ~/delivery/
    command cd ~/delivery/
    command git init
    command cd -
    echo -e "[${GREEN}OK${RESET}] Setup work delivery"
fi
