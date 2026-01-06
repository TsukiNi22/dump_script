# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

ZSH_THEME="robbyrussell"

export PATH=/home/mat/.cargo/bin:$PATH

unalias git
unalias mkdir

#plugins=(git)

source $ZSH/oh-my-zsh.sh

eval "$(zoxide init zsh)"
alias cd='z'

eval "$(thefuck --alias f)"

#my alias
alias edit='v ~/.zshrc && upd'
alias upd='source ~/.zshrc'

alias dump='\sudo make -C ~/personal_delivery/dump_script'

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
alias gd='\git diff'
alias gl='\git log'
alias ga='\git add'
alias gm='\git merge'
alias gcm='\git commit -m'
alias gp='\git push origin main'
alias gpl='\git pull origin main'
alias gc='\git clone'
alias gr='\git restore'
alias grm='\git rm'
alias gsw='\git switch'
alias gb='\git branch'
alias gpb='\git push origin'
alias gplb='\git pull origin'
alias grmb='\git push origin --delete'
alias grmbl='\git branch -D'

alias gsetup='\git add . && \git commit -m "setup commit" && \git push'
alias gcds='\git add . && \git commit -m "fix: coding-style" && \git push'

alias m='make -j'
alias mr='make re -j'
alias mf='make fclean'
alias ml='make lib -j'
alias mc='make clean'
alias mrc='make -j re && make clean'
alias md='make d=t -j'
alias mrd='make re d=t -j'
alias mfd='make fclean d=t'
alias mld='make lib d=t -j'
alias mcd='make d=t -j && make clean'
alias mrcd='make re d=t -j && make clean'
alias mo='make d=o -j'
alias mro='make re d=o -j'
alias mfo='make fclean d=o'
alias mlo='make lib d=o -j'
alias mco='make d=o -j && make clean'
alias mrco='make re d=o -j && make clean'
alias mgr='make get_unregistered_files'
alias mgk='make get_unknow_files'
alias c='make clean'
alias fc='make fclean'

alias t='rm -rf build; \mkdir build && cd build && cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release && cmake --build . && cd ..; rm -rf build'

alias vg='valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all --errors-for-leak-kinds=all'
alias vgr='vg 2> vg'
alias rvg='rm -f vg'

alias py='python3'
alias pex='python3 main.py'
alias p='python3'
alias rmpc='rm -rf $(find . -name "__pycache__")'
#alias cl="clear && figlet \"I'm  a  FUCKING  banana ! ! !\" && \ls -a --color"
#alias ct="clear && figlet \"I'm  a  FUCKING  banana ! ! !\" && tree"
alias cl="clear && fastfetch && \ls -a --color"
alias ct="clear && fastfetch && tree"
alias exi='exit'
alias sv='\sudo vi'
alias su='\sudo su'
alias tmp='\vi tmp_vi_file && rm -f tmp_vi_file'
alias rmtmp='find . \( -name "*.sw*" -o -name "#*#" -o -name "*~" \) -delete'
alias findfunc='grep -rnE ~/delivery/template/include/ --include="*.h" -e'
alias findc='grep -rnE . --include="*.c" -e'
alias findh='grep -rnE . --include="*.h" -e'
alias finda='grep -rnE . --include="*" -e'
alias cds='mf; coding-style . . && echo "-------------------------------------------------" && cat coding-style-reports.log && rm -f coding-style-reports.log'
alias goto=''
alias opgoto=''
alias vt='v tmp_file && rm -f tmp_file'
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

alias epi='docker run -it --rm -v $(pwd):/home/project:Z -w /home/project epitechcontent/epitest-docker:latest bash'
alias psdoc='docker ps -a'
alias stopdoc='docker container prune -f'

alias pw='upower -i $(upower -e | grep battery) | grep "percentage" | awk "{print \$2}"'
alias update='\sudo dnf update -y'
alias dnfi='\sudo dnf install'
alias dnfr='\sudo dnf remove'
alias setup_terminal='tmnh && tmux select-pane -L && tmnv && cd include && cl && tmux select-pane -R && tmux select-pane -R  && tmux send-keys "mf && cl && gpl && gst" C-m && tmux select-pane -R && tmux send-keys "cd src && cl && tree" C-m'

alias h='cd ~/delivery/year_1/mul/B-MUL-100-BDX-1-1-myhunter-mathias.dumoulin/ && ./my_hunter -l 3 -d 2. && cd -'
alias hd='cd ~/delivery/year_1/mul/B-MUL-100-BDX-1-1-myhunter-mathias.dumoulin/ && ./my_hunter -l 3 -d 2. -D && cd -'
alias tt="rm -f *.cor ; echo 'COMPILATION:' && m && echo && echo 'FILE:' && cat \$FILE && echo && echo 'OUR:' && ./asm \$FILE && mv *.cor our && hexdump -C our && echo && echo 'OTHER:' && ./binaries/asm/asm \$FILE && mv *.cor real && hexdump -C real && echo && echo 'DIFF:' && cmp -l our real | awk '{printf \"Diff at byte %d\n\", \$1 - 2192}' ; rm -f our real"

alias a='ani-cli'
alias ulimit_reset='ulimit -s 8192'

alias fastfetch="~/.config/fastfetch/rdm_img.sh"
alias streamlit="~/.local/bin/streamlit"

alias e='xeyes'
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

#lost

clear
fastfetch
sl

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
