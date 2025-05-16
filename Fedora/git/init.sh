export RED='\033[31m'
export GREEN='\033[32m'
export RESET='\033[0m'

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

command mkdir -p ~/delivery/aia ~/delivery/cpe ~/delivery/cyber ~/delivery/dop ~/delivery/eng ~/delivery/hub ~/delivery/mat ~/delivery/mul ~/delivery/pro ~/delivery/psu ~/delivery/workshop
echo -e "[${GREEN}OK${RESET}] Setup of the directory in delivery"
command cp -rf git/template ~/delivery/
echo -e "[${GREEN}OK${RESET}] Setup of the template for c project"
