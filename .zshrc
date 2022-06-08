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
alias t='tig'
alias ta='tig --all'
alias gg="git log --graph --pretty=format:'%Cred%h%Creset %C(blue)[%cs]%Creset %C(auto)%d%Creset- %s %C(bold cyan)<%an>%Creset' --abbrev-commit"
alias gga="git log --graph --pretty=format:'%Cred%h%Creset %C(blue)[%cs]%Creset %C(auto)%d%Creset- %s %C(bold cyan)<%an>%Creset' --abbrev-commit --all"
alias l='exa -lT --icons -L 1'
alias tree='exa -lT --icons'
alias gs='git status'
alias reboot='echo "Use sudo"'

# To define !
alias mu_commands="mu_commands.sh --cmd|fzf --preview-window=wrap --height=10 --border=vertical --preview 'mu_commands.sh --desc {}'| bash"
alias open_with_fzf="fzf --preview 'bat -p --wrap=never --paging=never --color=always {}' | xargs nvim"

bindkey -s '' "mu_commands"
bindkey -s '' "open_with_fzf"
bindkey -e
