# =============================================
# Oh My Zsh (safe load)
# =============================================
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_THEME=""                 # thème vide (prompt custom ci-dessous)
DISABLE_GIT_PROMPT=true      # évite le prompt git d'OMZ (on gère nous-mêmes)
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
[[ -s "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# =============================================
# Core Zsh & History (fast, useful defaults)
# =============================================
setopt prompt_subst
setopt autocd extendedglob interactivecomments
setopt hist_ignore_dups hist_ignore_space
setopt share_history inc_append_history_time
setopt no_beep

HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000
SAVEHIST=200000
HIST_STAMPS="yyyy-mm-dd"     # triable, format ISO

# mode emacs (bindkey -e par défaut), utf-8 propre
bindkey -e
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export EDITOR='nvim'
export VISUAL='nvim'

# =============================================
# Paths (idempotent & lisibles)
# =============================================
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export LBIN="$HOME/.local/bin"
path_prepend() { [[ ":$PATH:" == *":$1:"* ]] || PATH="$1${PATH:+:$PATH}"; }
path_prepend "$LBIN"
path_prepend "$HOME/ed-personal/bin"

# Java (garde-fou)
_JAVA_VERSION="${_JAVA_VERSION:-17}"
if [[ -d "/usr/lib/jvm/java-$_JAVA_VERSION-openjdk" ]]; then
  export JAVA_HOME="/usr/lib/jvm/java-$_JAVA_VERSION-openjdk"
  path_prepend "$JAVA_HOME/bin"
fi

# =============================================
# Prompt minimal lisible (HH:MM:SS + cwd)
# =============================================
autoload -Uz colors && colors
PROMPT='%F{red}%D{%H:%M:%S}%f %F{yellow}%~%f '

# =============================================
# Aliases (avec fallbacks & couleurs)
# Remarque: eza remplace exa. On propose eza si dispo, sinon ls.
# =============================================
alias xc='xclip -sel clipboard'

# bat : remplace cat, mais garde options propres pour scripts
if command -v bat >/dev/null 2>&1; then
  alias b='bat'
  alias bf='bat --style=header-filename --paging=never'
  alias bd='bat --style=changes'
  alias cat='bat -p --color=never --paging=never'
fi

# eza / exa / ls
if command -v eza >/dev/null 2>&1; then
  alias l='eza -l --icons'
  alias ll='eza -l --icons --group --git'
  alias tree='eza -T -l --icons'
elif command -v exa >/dev/null 2>&1; then
  alias l='exa -l --icons'
  alias ll='exa -l --icons --group --git'
  alias tree='exa -T -l --icons'
else
  alias l='ls -lAh --color=auto'
  alias ll='ls -lah --color=auto'
  alias tree='ls -R'
fi

alias rm='rip'  # rip = trash sécurisé (si installé)
alias pl='pgrep -l'
alias reboot='echo "Use sudo"'
alias ip='ip -c'

# Git
alias gs='git status'
alias gaw='git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero'
alias grp='git rev-parse HEAD'

# Docker (avec garde si docker-color-output absent)
DOCKER_COLOR_OUTPUT_CF="$HOME/.docker-color-output/config.json"
_dco() {
  if command -v docker-color-output >/dev/null 2>&1; then
    docker-color-output -c "${DOCKER_COLOR_OUTPUT_CF}"
  else
    cat
  fi
}
alias dps='docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Status}}\t{{.Ports}}" | _dco'
alias dpsa='docker ps -a --format "table {{.Names}}\t{{.ID}}\t{{.Status}}\t{{.Ports}}" | _dco'
alias dpss='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" | _dco'
alias dils='docker image ls | _dco'
alias dcls='docker container ls | _dco'
alias dcps='docker compose ps | _dco'

# =============================================
# Small functions
# =============================================
# Docker shortcuts
d()  { docker "$@"; }
dc() { docker compose "$@"; }
de() { docker exec "$@"; }

# Open a file via fzf (plus stable que `vf='nvim \`fd $@\`'`)
vf() {
  local q="${*:-}"
  local src="fd --type f --hidden --follow --exclude .git --exclude .ccls-cache ${q}"
  local file
  file=$(eval "$src" | fzf) || return
  nvim "$file"
}

# =============================================
# External Tools init
# =============================================
# Zoxide
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# FZF (recherche rapide par défaut)
if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .ccls-cache'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# =============================================
# tmux helpers (widgets ZLE propres)
# =============================================
attach_tmux_session() {
  zle -I
  local session
  session=$(tmux ls 2>/dev/null | fzf | awk -F: '{print $1}')
  if [[ -n "$session" ]]; then
    tmux attach -t "$session"
  else
    echo "Aucune session tmux sélectionnée."
  fi
  zle reset-prompt
}
zle -N attach_tmux_session

new_tmux_session() {
  zle -I
  local session_name
  read -r "session_name?Nom de la session tmux (vide = nom par défaut) : "
  if [[ -z $session_name ]]; then
    tmux new
  else
    tmux new -s "$session_name"
  fi
  zle reset-prompt
}
zle -N new_tmux_session

# =============================================
# Key bindings (Ctrl-? codes maintenus)
# =============================================
bindkey -s '' "$HOME/dotfiles/rofi/rofi-ssh-wezterm-inline.sh\n"  # C-o ?
bindkey -s '' "$HOME/dotfiles/rofi/rofi-mariadb.sh\n"             # C-p ?
bindkey -s '' "new_tmux_session\n"                                # C-n
bindkey -s '' "attach_tmux_session\n"                             # C-t

# =============================================
# Theme Management (GNOME/Cinnamon safe)
# =============================================
update_theme() {
  local BG_THEME
  if command -v gsettings >/dev/null 2>&1; then
    BG_THEME=$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null | tr -d "'")
  fi

  # Base couleurs pour eza/exa (si fichier dispo côté clair)
  if [[ -f "$HOME/dotfiles/exa/common-light.sh" ]]; then
    # définit EXA_BASE
    # shellcheck disable=SC1091
    source "$HOME/dotfiles/exa/common-light.sh"
  fi

  if [[ "$BG_THEME" == "prefer-light" || "$BG_THEME" == "default" ]]; then
    command -v vivid >/dev/null 2>&1 && export EXA_COLORS="${EXA_BASE:+$EXA_BASE:}$(vivid generate rose-pine)"
    export BAT_THEME="Solarized (light)"
    export VIM_BACKGROUND=light
    export BACKGROUND=light
  elif [[ "$BG_THEME" == "prefer-dark" ]]; then
    command -v vivid >/dev/null 2>&1 && export EXA_COLORS="${EXA_BASE:+$EXA_BASE:}$(vivid generate lava)"
    export BAT_THEME="Nord"
    export VIM_BACKGROUND=dark
    export BACKGROUND=dark
  else
    # fallback si pas GNOME (Cinnamon, etc.)
    export VIM_BACKGROUND=${VIM_BACKGROUND:-dark}
    export BACKGROUND=${BACKGROUND:-dark}
  fi
}

# Init thème
update_theme

# =============================================
# Desktop tweaks (avec garde)
# =============================================
if command -v gsettings >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 20 2>/dev/null || true
  gsettings set org.gnome.desktop.peripherals.keyboard delay 250 2>/dev/null || true
  # Cinnamon (décommente si tu utilises Cinnamon)
  # gsettings set org.cinnamon.desktop.peripherals.keyboard delay 250 2>/dev/null || true
  # gsettings set org.cinnamon.desktop.peripherals.keyboard repeat-interval 20 2>/dev/null || true
fi

# =============================================
# Completion (rapide + cache)
# =============================================
autoload -Uz compinit
# compaudit silencieux + cache dans ~/.zcompdump
if ! compinit -C 2>/dev/null; then
  compinit
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''

# =============================================
# Local overrides
# =============================================
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# clear à la fin = optionnel (parfois agaçant)
# clear


# =============================================
# FNM for node
# =============================================
FNM_PATH="/home/guillaume/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
