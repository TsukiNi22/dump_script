# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

ZSH_THEME="robbyrussell"

export PATH=$HOME/bin:$HOME/.cargo/bin:/opt/gbdk/bin:$PATH

# Before oh-my-zsh -> its compinit loads them
fpath=(~/.zsh/completions $fpath)

unalias git 2> /dev/null
unalias mkdir 2> /dev/null

#plugins=(git)

source $ZSH/oh-my-zsh.sh

#eval "$(thefuck --alias f)"

#my alias
alias edit='v ~/.zshrc && upd'
alias upd='source ~/.zshrc'

alias dump='\sudo make -C ~/dump'

alias lock='echo bruh!!!; loginctl lock-session;'

alias sudo='lock'
alias vi='lock'
alias vim='lock'
alias nvim='lock'
alias nano='lock'
alias git='lock'
alias sh='lock'
alias curl='lock'
alias mkdir='lock'
alias ls='\sl'

alias s='\sudo'
alias bv='\vi'
alias vm='\vim'
alias v='\nvim'
alias na='\nano'
alias em='\emacs'
alias g='\git'
alias shh='\sh'
alias cur='\curl'
alias mk='\mkdir'
alias sl='\ls -a --color'

alias gst='\git status'
alias gca='\git commit --amend'
alias gck='\git checkout'
alias gd='\git diff'
alias gl='\git log'
alias ga='\git add'
alias gm='\git merge'
alias gcm='\git commit -m'
alias gp='\git push origin main'
alias kipe_puchinge='\git push origin main --force'
alias gpl='\git pull origin main'
alias gt='\git tag'
alias gc='\git clone'
alias gr='\git restore'
alias grm='\git rm'
alias gsw='\git switch'
alias gb='\git branch'
alias gpb='\git push origin'
alias gpbt='\git push origin --tags'
alias gplb='\git pull origin'
alias grmb='\git push origin --delete'
alias grmbl='\git branch -D'
alias grmtl='\git tag -d'

alias gsetup='\git add --force cmake/; \git add . && \git commit -m "setup commit" && \git push'
alias gcds='\git add . && \git commit -m "fix: coding-style" && \git push'

alias m='make -j $(nproc)'
alias mr='make re -j $(nproc)'
alias mc='make clean'
alias mf='make fclean'
alias md='make d=t -j $(nproc)'
alias mrd='make re d=t -j $(nproc)'
alias mo='make d=o -j $(nproc)'
alias mro='make re d=o -j $(nproc)'
alias mgr='make get_unregistered_files'
alias mgk='make get_unknow_files'

export BUILD_DIR="build"
alias build='cmake -S . -B $BUILD_DIR'
alias buildT='cmake -S . -B $BUILD_DIR -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTS=ON'
alias buildD='cmake -S . -B $BUILD_DIR -DCMAKE_BUILD_TYPE=Debug'
alias buildA='cmake -S . -B $BUILD_DIR -DCMAKE_BUILD_TYPE=Asan'
alias buildO='cmake -S . -B $BUILD_DIR -DCMAKE_BUILD_TYPE=Optimized'
alias cmc='cmake --build $BUILD_DIR --target clean 2> /dev/null'
alias cmf='cmc; rm -rf $BUILD_DIR'
alias cmake_no_target='cmake --build $BUILD_DIR --parallel $(nproc)'
alias cm='build && cmake_no_target'
alias cmt='buildT && cmake_no_target'
alias cmd='buildD && cmake_no_target'
alias cma='buildA && cmake_no_target'
alias cmo='buildO && cmake_no_target'
alias cmR='build && cmake --build $BUILD_DIR --target release --parallel $(nproc)'
alias cmi='build && s cmake --build $BUILD_DIR --target install --parallel $(nproc)'
alias cmiR='build && s cmake --build $BUILD_DIR --target install_release --parallel $(nproc)'
alias cmpR='build && cmake --build $BUILD_DIR --target package_release --parallel $(nproc)'
alias cmr='cmf; cm'
alias cmrt='cmf; cmt'
alias cmrd='cmf; cmd'
alias cmra='cmf; cma'
alias cmro='cmf; cmo'
alias cmrR='cmf; cmR'
alias cmri='cmf; cmi'
alias cmriR='cmf; cmiR'
alias cmrpR='cmf; cmpR'
alias cmgr='build && cmake --build $BUILD_DIR --target get_unregistered_files'
alias cmdoc='docker run -it --rm \
    -u root \
    -v $(pwd):/home/project:Z \
    $IMAGE bash -c "
        apt-get update -qq &&
        apt-get install -y clang cmake make python3 pkg-config &&
        cd /home/project &&
        cmake -S . -B build &&
        cmake --build build --target release --parallel \$(nproc)"
'
alias cmepi='docker run -it --rm \
    -u root \
    -v $(pwd):/home/project:Z \
    epitechcontent/epitest-docker:latest bash -c "
        apt-get update -qq &&
        apt-get install -y clang cmake make python3 pkg-config &&
        cd /home/project &&
        cmake -S . -B build &&
        cmake --build build --target release --parallel \$(nproc)"
'
alias docker-compose-reup='docker-compose down -v && docker-compose up --build'

alias ctb='ctest --test-dir $BUILD_DIR'

alias t='rm -rf build; \mkdir build && cd build && cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release && cmake --build . && cd ..; rm -rf build'
alias cds='mf; coding-style . . && echo "-------------------------------------------------" && cat coding-style-reports.log && rm -f coding-style-reports.log'

alias vg='valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all --errors-for-leak-kinds=all'
alias vgr='vg 2> vg'
alias rvg='rm -f vg'

alias rmtmp='find . \( -name "*.sw*" -o -name "#*#" -o -name "*~" \) -delete'
alias tmp='\vi tmp_vi_file && rm -f tmp_vi_file'
alias vt='v tmp_file && rm -f tmp_file'

alias findfunc='grep -rnE . --include="*.h" --include="*.hpp" -- -e'
alias findc='grep -rnE . --include="*.c" -e'
alias findh='grep -rnE . --include="*.h" -e'
alias findcpp='grep -rnE . --include="*.cpp" -e'
alias findhpp='grep -rnE . --include="*.hpp" -e'
alias finda='grep -rnE . --include="*" -e'
alias findx='grep -rnE . -e --include='
alias nbla='find . -type f ! -path "*/.*" -exec wc -l {} +'
alias nblp='find . -type f -name "*.py" -exec wc -l {} +'
alias nblc='find . -type f \( -name "*.c" -o -name "*.h" \) -exec wc -l {} +'
alias nblcpp='find . -type f \( -name "*.cpp" -o -name "*.hpp" \) -exec wc -l {} +'

alias py='python3'
alias pex='python3 main.py'
alias p='python3'
alias rmpc='rm -rf $(find . -name "__pycache__")'
#alias cl="clear && figlet \"I'm  a  FUCKING  banana ! ! !\" && \ls -a --color"
#alias ct="clear && figlet \"I'm  a  FUCKING  banana ! ! !\" && tree"
alias cl="clear && fastfetch && \ls -a --color"
alias ct="clear && fastfetch && tree"
alias exi='exit'
alias sv='\sudo nvim'
alias su='\sudo su'
alias goto=''
alias opgoto=''
alias lum='\sudo vim /sys/class/backlight/intel_backlight/brightness'

alias ssh2john='~/john/run/ssh2john.py'

alias cs='cd src/'
alias clb='cd lib/my/'
alias cdd='cd ~/delivery/'
alias cddt='cd ~/delivery/template'
alias cdp='cd ~/personal_delivery/'

alias tm='tmux'
alias tmnh='tmux split-window -h'
alias tmnv='tmux split-window -v'

alias doc='docker run -it --rm -v $(pwd):/home/project:Z -w /home/project ubuntu:24.04 bash'
alias docc='docker run -it --rm -v $(pwd):/home/project:Z -w /home/project $IMAGE bash'
alias epi='docker run -it --rm -v $(pwd):/home/project:Z -w /home/project epitechcontent/epitest-docker:latest bash'
alias psdoc='docker ps -a'
alias stopdoc='docker container prune -f'

alias pw='upower -i $(upower -e | grep battery) | grep "percentage" | awk "{print \$2}"'
alias update='\sudo dnf update -y'
alias dnfi='\sudo dnf install'
alias dnfr='\sudo dnf remove'
alias setup_terminal='tmnh && tmux select-pane -L && tmnv && cd include && cl && tmux select-pane -R && tmux select-pane -R  && tmux send-keys "mf && cl && gpl && gst" C-m && tmux select-pane -R && tmux send-keys "cd src && cl && tree" C-m'

alias h='cd ~/delivery/year_1/B-MUL-100-BDX-1-1-myhunter-mathias.dumoulin/ && ./my_hunter -l 3 -d 2. && cd -'
alias hd='cd ~/delivery/year_1/B-MUL-100-BDX-1-1-myhunter-mathias.dumoulin/ && ./my_hunter -l 3 -d 2. -D && cd -'
alias tt="rm -f *.cor ; echo 'COMPILATION:' && m && echo && echo 'FILE:' && cat \$FILE && echo && echo 'OUR:' && ./asm \$FILE && mv *.cor our && hexdump -C our && echo && echo 'OTHER:' && ./binaries/asm/asm \$FILE && mv *.cor real && hexdump -C real && echo && echo 'DIFF:' && cmp -l our real | awk '{printf \"Diff at byte %d\n\", \$1 - 2192}' ; rm -f our real"

alias a='ani-cli'
alias ulimit_reset='ulimit -s 8192'

alias fastfetch="~/.config/fastfetch/rdm_img.sh"
alias streamlit="~/.local/bin/streamlit"
alias linpeas='\curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | \sh'

alias e='xeyes'
alias exegol='\sudo -E $HOME/.local/bin/exegol'
alias rtfm='zenity --info --title="Just" --width=700 --height=400 --text="<span font='\''75'\'' color='\''red'\''><b>RTFM</b></span>\n\n<span font='\''20'\''>READ THE F***ING MANUAL!!!</span>"'
alias lost='zenity --info --title="Just" --width=700 --height=400 --text="<span font='\''75'\'' color='\''red'\''><b>DEVINE QUOI</b></span>\n\n<span font='\''20'\''>j'\''ai perdu!</span>"'
alias tsukini='unalias sudo && unalias vi && unalias vim && unalias nvim && unalias nano && unalias git && unalias sh && unalias curl && unalias mkdir && unalias ls && cl'
alias morse="bash | sed 's/[aA]/._ /g;s/[bB]/_... /g;s/[cC]/_._. /g;s/[dD]/_.. /g;s/[eE]/. /g;s/[fF]/.._. /g;s/[gG]/__. /g;s/[hH]/.... /g;s/[iI]/.. /g; s/[jJ]/.___ /g;s/[kK]/_._ /g;s/[lL]/._.. /g;s/[mM]/__ /g;s/[nN]/_. /g;s/[oO]/___ /g;s/[pP]/.__. /g;s/[qQ]/__._ /g;s/[rR]/._. /g;s/[sS]/... /g;s/[tT]/_ /g;s/[uU]/.._ /g;s/[vV]/..._ /g;s/[wW]/.__ /g;s/[xX]/_.._ /g;s/[yY]/_.__ /g;s/[zZ]/__.. /g'"
alias tg='echo "_ ._  __. . .._ ._.. ." && play -n synth 0.9 sine 800 >/dev/null 2>&1; sleep 0.3; \
    play -n synth 0.3 sine 800 >/dev/null 2>&1; sleep 0.3; \
    play -n synth 0.1 sine 800 >/dev/null 2>&1; sleep 0.1; \
    play -n synth 0.3 sine 800 >/dev/null 2>&1; sleep 0.3; \
    play -n synth 0.3 sine 800 >/dev/null 2>&1; sleep 0.1; \
    play -n synth 0.3 sine 800 >/dev/null 2>&1; sleep 0.1; \
    play -n synth 0.1 sine 800 >/dev/null 2>&1; sleep 0.3; \
    play -n synth 0.1 sine 800 >/dev/null 2>&1; sleep 0.3; \
    play -n synth 0.1 sine 800 >/dev/null 2>&1; sleep 0.1; \
    play -n synth 0.1 sine 800 >/dev/null 2>&1; sleep 0.1; \
    play -n synth 0.3 sine 800 >/dev/null 2>&1; sleep 0.3; \
    play -n synth 0.1 sine 800 >/dev/null 2>&1; sleep 0.1; \
    play -n synth 0.3 sine 800 >/dev/null 2>&1; sleep 0.1; \
    play -n synth 0.1 sine 800 >/dev/null 2>&1; sleep 0.1; \
    play -n synth 0.1 sine 800 >/dev/null 2>&1; sleep 0.3; \
    play -n synth 0.1 sine 800 >/dev/null 2>&1
'

alias ip_pub='\curl ipinfo.io/ip'
alias init_ethernet_share=' \
    \sudo iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE; \
    \sudo iptables -A FORWARD -i $ETHERNET -o wlo1 -j ACCEPT; \
    \sudo iptables -A FORWARD -i wlo1 -o $ETHERNET -m state --state RELATED,ESTABLISHED -j ACCEPT;
'
alias init_ethernet_share3=' \
    \sudo iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE; \
    \sudo iptables -A FORWARD -i enp3s0 -o wlo1 -j ACCEPT; \
    \sudo iptables -A FORWARD -i wlo1 -o enp3s0 -m state --state RELATED,ESTABLISHED -j ACCEPT;
'
alias init_ethernet_share4=' \
    \sudo iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE; \
    \sudo iptables -A FORWARD -i enp4s0 -o wlo1 -j ACCEPT; \
    \sudo iptables -A FORWARD -i wlo1 -o enp4s0 -m state --state RELATED,ESTABLISHED -j ACCEPT;
'

alias force_ip=' \
    \sudo ip addr add 192.168.50.1/24 dev $ETHERNET; \
    \sudo ip link set $ETHERNET up;
'
alias force_ip3=' \
    \sudo ip addr add 192.168.50.1/24 dev enp3s0; \
    \sudo ip link set enp3s0 up;
'
alias force_ip4=' \
    \sudo ip addr add 192.168.50.1/24 dev enp4s0; \
    \sudo ip link set enp4s0 up;
'

ollama-hosted() {
    local action="-run"

    if [[ "$1" == "-run" || "$1" == "-stop" ]]; then
        action="$1"
        shift
    fi

    local ssh_pid
    if [[ "$action" == "-stop" ]]; then
        ssh_pid=$(pgrep -n -f 'ssh -N -f ai-server')
        if [[ -n "$ssh_pid" ]]; then
            kill "$ssh_pid"
            echo "Ollama SSH stopped (PID $ssh_pid)"
        else
            echo "No Ollama SSH found"
        fi

        return 0
    fi

    ssh -N -f ai-server
    ssh_pid=$(pgrep -n -f 'ssh -N -f ai-server')

    OLLAMA_HOST=http://127.0.0.1:11435 ollama "$@"
    local exit_code=$?

    kill "$ssh_pid" 2>/dev/null
    return $exit_code
}

# adress ip: 192.168.50.2
# masque: 255.255.255.0
# passerelle: 192.168.50.1
# DNS-1: 1.1.1.1
# DNS-2: 8.8.4.4

#lost

clear
fastfetch
sl

# Created by `pipx` on 2026-01-13 13:17:45
export PATH="$PATH:$HOME/.local/bin"

# NPM global bin (added by Qwen Code installer)
export PATH="$HOME/.npm-global/bin:$PATH"

# opencode
export PATH=$HOME/.opencode/bin:$PATH

# js android
export CAPACITOR_ANDROID_STUDIO_PATH=/usr/local/bin/android-studio-flatpak

# >>> context-forge completion >>>
# Added by context-forge setup.sh (remove this block to disable it)
# /usr/local: install from the sources (cmake), /usr: install from the packages
for _cf_dir in /usr/local/share/zsh/site-functions /usr/share/zsh/site-functions; do
    if [[ -r "$_cf_dir/_context-forge" ]]; then
        (( ${fpath[(Ie)$_cf_dir]} )) || fpath=("$_cf_dir" $fpath)
        _cf_found=1
        break
    fi
done
if (( ${+_cf_found} )); then
    # compinit already done (oh-my-zsh, ...) -> only register the completion
    if (( ${+functions[compdef]} )); then
        autoload -Uz _context-forge && compdef _context-forge context-forge
    else
        autoload -Uz compinit && compinit -i
    fi
fi
unset _cf_dir _cf_found
# <<< context-forge completion <<<

# >>> tsukini-skills completion >>>
# Added by the skills setup.sh (remove this block to disable it): completion of xstyle
_ts_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/site-functions"
(( ${fpath[(Ie)$_ts_dir]} )) || fpath=("$_ts_dir" $fpath)
if (( ${+functions[compdef]} )); then
    # compinit already done (oh-my-zsh, ...) -> only register the completions
    for _ts_tool in xstyle; do
        autoload -Uz "_$_ts_tool" && compdef "_$_ts_tool" "$_ts_tool"
    done
else
    autoload -Uz compinit && compinit -i
fi
unset _ts_dir _ts_tool
# <<< tsukini-skills completion <<<

# Must stay at the end of the file (zoxide doctor)
eval "$(zoxide init zsh)"
alias cd='z'
