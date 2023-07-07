# ZSH_THEME="headline"

# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"

HIST_STAMPS="mm/dd/yyyy"

# ZSH_CUSTOM=/path/to/new-custom-folder
plugins=(git zoxide zsh-autosuggestions colored-man-pages compleat fzf ssh-agent )

source $ZSH/oh-my-zsh.sh

alias b='bat'
alias bd='bat --style=changes'
alias cat='bat -p --wrap=never --paging=never'
alias rm='rip'
alias l='exa -lT --icons -L 1'
alias tree='exa -lT --icons'
alias pl='pgrep -l'
alias gs='git status'
alias gaw='git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero'
alias grp='git rev-parse HEAD'
alias reboot='echo "Use sudo"'

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .ccls-cache'

# To define !
alias mu_commands='eval $(mu_commands.sh --cmd|fzf --preview-window=wrap --height=25 --border=vertical --preview "mu_commands.sh --desc {}")'
alias open_with_fzf="fzf --preview 'bat -p --wrap=never --paging=never --color=always {}' | xargs nvim"

bindkey -s '' "mu_commands"
# bindkey -s '' "open_with_fzf"
bindkey -e

if [ "$TERM" = "alacritty" ]; then
    source $HOME/dotfiles/alacritty/alacritty-zsh
fi

if [ "$TERM" = "xterm-kitty" ]; then
    kitty @ set-background-opacity 0.8
fi


export LUA_PATH="${LUA_PATH};${HOME}/.config/nvim/local/?.lua"
