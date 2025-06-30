## Note : ln -sf dotfiles/.zshrc ~/.zshrc
# =============================================
# Oh My Zsh Configuration
# =============================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="spaceship"
plugins=(
  git 
  zoxide 
  zsh-autosuggestions 
  colored-man-pages 
  fzf 
  ssh-agent 
  zsh-syntax-highlighting 
  zsh-autopair
)
source $ZSH/oh-my-zsh.sh

# =============================================
# Core Zsh Settings
# =============================================
HIST_STAMPS="mm/dd/yyyy"
bindkey -e
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='nvim'
export VISUAL='nvim'

# =============================================
# Path Configuration
# =============================================
export XDG_CONFIG_HOME="$HOME/.config"
export LBIN="$HOME/.local/bin"
export PATH="$LBIN:$HOME/ed-personal/bin:$PATH"

# Java configuration
_JAVA_VERSION=17
export JAVA_HOME="/usr/lib/jvm/java-$_JAVA_VERSION-openjdk"
PATH="$JAVA_HOME/bin:$PATH"

# =============================================
# Aliases
# =============================================
# General
alias xc='xclip -sel clipboard'
alias b='bat'
alias bd='bat --style=changes'
alias cat='bat -p --wrap=never --paging=never -f'
alias rm='rip'
alias l='exa -lT --icons -L 1'
alias ll='exa -l --icons'
alias tree='exa -lT --icons'
alias pl='pgrep -l'
alias reboot='echo "Use sudo"'
alias vf='nvim `fd $@`'
alias ssh='TERM=xterm-256color ssh $@'

# Git
alias gs='git status'
alias gaw='git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero'
alias grp='git rev-parse HEAD'

# Docker
DOCKER_COLOR_OUTPUT_CF="$HOME/.docker-color-output/config.json"
alias dps='docker ps --format "table {{.Names}}\\t{{.ID}}\\t{{.Status}}\\t{{.Ports}}" | docker-color-output -c ${DOCKER_COLOR_OUTPUT_CF}'
alias dpsa='docker ps -a --format "table {{.Names}}\\t{{.ID}}\\t{{.Status}}\\t{{.Ports}}" | docker-color-output -c ${DOCKER_COLOR_OUTPUT_CF}'
alias dpss='docker ps --format "table {{.Names}}\\t{{.ID}}\\t{{.Image}}\\t{{.Status}}\\t{{.Ports}}" | docker-color-output -c ${DOCKER_COLOR_OUTPUT_CF}'
alias dils='docker image ls | docker-color-output -c ${DOCKER_COLOR_OUTPUT_CF}'
alias dcls='docker container ls | docker-color-output -c ${DOCKER_COLOR_OUTPUT_CF}'
alias dcps='docker compose ps | docker-color-output -c ${DOCKER_COLOR_OUTPUT_CF}'

# =============================================
# Functions
# =============================================
# Docker shortcuts
d() { docker "$@" }
dc() { docker compose "$@" }
de() { docker exec "$@" }

# =============================================
# External Tools
# =============================================
# Zoxide
eval "$(zoxide init zsh)"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .ccls-cache'

# Lazy loading for nvm
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

# =============================================
# Bindkeys & Shortcuts
# =============================================
bindkey -s '' "$HOME/dotfiles/rofi/rofi-ssh.sh\n"
bindkey -s '' "$HOME/dotfiles/rofi/rofi-mariadb.sh\n"
bindkey -s '' "$HOME/dotfiles/rofi/rofi-gitui.sh\n"

# =============================================
# Theme Management (GNOME-specific)
# =============================================
update_theme() {
  local BG_THEME=$(gsettings get org.gnome.desktop.interface color-scheme | tr -d "'")
  if [ "$BG_THEME" = "prefer-light" ] || [ "$BG_THEME" = "default" ]; then
    source "$HOME/dotfiles/exa/common-light.sh"
    export EXA_COLORS="$EXA_BASE:$(vivid generate rose-pine)"
    export BAT_THEME="Solarized (light)"
    export VIM_BACKGROUND=light
  elif [ "$BG_THEME" = "prefer-dark" ]; then
    export EXA_COLORS="$EXA_BASE:$(vivid generate lava)"
    export BAT_THEME="Nord"
    export VIM_BACKGROUND=dark
  else
    echo "Unknown theme: $BG_THEME"
  fi
}

# Use UI Dash To Panel
# fzf_gnome_theme_switch() {
#   local choice
#   choice=$(printf "🌞 Light\n🌙 Dark" | fzf --prompt="Choisis un thème : " --height=10 --reverse)
#   if [[ "$choice" == *Light* ]]; then
#     gsettings set org.gnome.desktop.interface color-scheme prefer-light
#     gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
#     update_theme
#     echo "Thème GNOME : clair"
#   elif [[ "$choice" == *Dark* ]]; then
#     gsettings set org.gnome.desktop.interface color-scheme prefer-dark
#     gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
#     update_theme
#     echo "Thème GNOME : sombre"
#   fi
# }
#
# zle -N fzf_gnome_theme_switch
# bindkey '^T' fzf_gnome_theme_switch

# Initialize theme
update_theme
#
# =============================================
# GNOME desktop configuration
# =============================================
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 20
gsettings set org.gnome.desktop.peripherals.keyboard delay 250

# =============================================
# Local Configuration (non-committed)
# =============================================
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

