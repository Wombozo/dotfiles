# ZSH_THEME="headline"

HIST_STAMPS="mm/dd/yyyy"

# ZSH_CUSTOM=/path/to/new-custom-folder
plugins=(git zoxide zsh-autosuggestions colored-man-pages compleat fzf ssh-agent zsh-syntax-highlighting zsh-autopair)
eval "$(navi widget zsh)"

source $ZSH/oh-my-zsh.sh

alias b='bat'
alias bd='bat --style=changes'
alias cat='bat -p --wrap=never --paging=never -f'
alias rm='rip'
alias l='exa -lT --icons -L 1'
alias tree='exa -lT --icons'
alias pl='pgrep -l'
alias gs='git status'
alias gaw='git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero'
alias grp='git rev-parse HEAD'
alias reboot='echo "Use sudo"'
alias vf='nvim `fd $@`'

DOCKER_COLOR_OUTPUT_CF=$HOME/.docker-color-output/config.json
alias dps='docker ps --format "table {{.Names}}\\t{{.ID}}\\t{{.Status}}\\t{{.Ports}}"|docker-color-output -c ${DOCKER_COLOR_OUTPUT_CF}'
alias dpsa='docker ps -a --format "table {{.Names}}\\t{{.ID}}\\t{{.Status}}\\t{{.Ports}}"|docker-color-output -c ${DOCKER_COLOR_OUTPUT_CF}'
alias dpss='docker ps --format "table {{.Names}}\\t{{.ID}}\\t{{.Image}}\\t{{.Status}}\\t{{.Ports}}" |docker-color-output -c ${DOCKER_COLOR_OUTPUT_CF}'
alias dils='docker image ls |docker-color-output -c ${DOCKER_COLOR_OUTPUT_CF}'
alias dcls='docker container ls |docker-color-output -c ${DOCKER_COLOR_OUTPUT_CF}'
alias dcps='docker compose ps |docker-color-output -c ${DOCKER_COLOR_OUTPUT_CF}'

d() {
  docker "$@" 
}

dc() {
    docker compose "$@"
}

de() {
    docker exec "$@"
}

# Not working
# dcps() {
#     docker compose ps |docker-color-output -c ${DOCKER_COLOR_OUTPUT_CF}
# }



export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .ccls-cache'

# To define !
alias mu_commands='eval $(mu_commands.sh --cmd|fzf --preview-window=wrap --height=25 --border=vertical --preview "mu_commands.sh --desc {}")'
alias open_with_fzf="fzf --preview 'bat -p --wrap=never --paging=never --color=always {}' | xargs nvim"

# bindkey -s '' "mu_commands"
# bindkey -s '' "open_with_fzf"
bindkey -s '' "/home/guillaume/dotfiles/rofi/rofi-ssh.sh"
bindkey -s '' "/home/guillaume/dotfiles/rofi/rofi-mariadb.sh"
bindkey -s '' "/home/guillaume/dotfiles/rofi/rofi-gitui.sh"
bindkey -e

if [ "$TERM" = "alacritty" ]; then
    source $HOME/dotfiles/alacritty/alacritty-zsh
fi

# if [ "$TERM" = "xterm-kitty" ]; then
#     kitty @ set-background-opacity 0.8
# fi


export LUA_PATH="${LUA_PATH};${HOME}/.config/nvim/local/?.lua"

# if ! pgrep -x devilspie > /dev/null; then
#     devilspie &
# fi

export NVM_DIR="$HOME/.nvm"
lazy_nvm() {
  unset -f node npm nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm use default &> /dev/null
  command "$@"
}
node() { lazy_nvm node "$@"; }
npm()  { lazy_nvm npm "$@"; }
nvm()  { lazy_nvm nvm "$@"; }


#####################
# Example $HOME/.zshrc
# export ZSH
# export ZSH=$HOME/.oh-my-zsh
#
# ZSH_THEME="spaceship"
#
# export XDG_CONFIG_HOME="$HOME/.config"
#
# zstyle :omz:plugins:ssh-agent identities id_rsa_gitlab id_rsa_github id_rsa
# source ~/dotfiles/.zshrc
#
# # export LS_COLORS="$(vivid generate one-dark)"
# # di_value=$(echo $LS_COLORS | sed -n 's/.*:di=\([^:]*\).*/\1/p')
# # json_value=$(echo $LS_COLORS | sed -n 's/.*\.json=\([^:]*\).*/\1/p')
# # md_value=$(echo $LS_COLORS | sed -n 's/.*\*\.md=\([^:]*\).*/\1/p')
#
# ### EXA
# source $HOME/dotfiles/exa/common-light.sh
# export EXA_COLORS="$EXA_BASE:$(vivid generate catppuccin-latte)"
# ###
#
#
# export LBIN="/home/guillaume/.local/bin"
#
# $HOME/ed-personal/bin/export_mu_commands.sh
#
# PATH="$LBIN:$HOME/ed-personal/bin:$PATH"
#
# export TARGET="target"
#
# _route_ip=$(ip route|grep ^default|grep enp|cut -d ' ' -f3)
# if [[ "${_route_ip}" == "192.168.1.254" ]]; then
#   export TARGET="targetHome"
# fi
#
# alias minicom='minicom -c on'
# alias scp='scp -O'
#
# #  srcery,  catppuccin, spacecamp, ayu, everforest, melange, badwolf, papercolor, fairyfloss, cobalt, sonokai, inkpot, andromeda, omni
# # export VIM_THEME='srcery'
# # if [ "$TERM" = "alacritty" ]; then
# #     # export VIM_THEME='lvim-dark'
# #     export VIM_THEME='srcery'
# # fi
#
# export EDITOR='nvim'
# export VISUAL='nvim'
#
# # bindkey -s '' "TERM=xterm ssh $TARGET
# "
#
# gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 20
# gsettings set org.gnome.desktop.peripherals.keyboard delay 250
#
# export BOARD_ID=33751156
#
# alias ssht='TERM=xterm ssh'
#
# #export NVM_DIR="$HOME/.config/nvm"
# #[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# #[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
#
# # source ~/.nvm/nvm.sh; nvm use 20
#
# #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
#
# _JAVA_VERSION=17
# export JAVA_HOME=/usr/lib/jvm/java-${_JAVA_VERSION}-openjdk
# PATH=$JAVA_HOME/bin:$PATH


