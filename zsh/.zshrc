export PATH export STARSHIP_CONFIG=~/.config/starship.toml # NOTE: Keep this at the top of all other functiions or the grep/awk combo won't work corectly

bindkey -v

# ------------------------------------------------------------------------------
# COMPLETION CONFIGURATION
# ------------------------------------------------------------------------------

# Initialize the completion system
# -U: allow aliases, -z: zsh style initialization
autoload -Uz compinit && compinit 

# Set completion styles for better usability
# Use caching to speed up subsequent loads
zstyle ':completion:*' use-cache true
# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Group completions by type
zstyle ':completion:*' group-name ''
# Enable menu completion (cycle through options with Tab)
zstyle ':completion:*:*:*:*:*' menu select
# Add color coding to completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Show descriptions for commands/options
zstyle ':completion:*:descriptions' format '%B%d%b'
# Show group headers for completions
zstyle ':completion:*:*:*:*:*' group-name ''

# Example: Nicer display for kill command completions
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ------------------------------------------------------------------------------
# HISTORY CONFIGURATION
# ------------------------------------------------------------------------------

# History file location
HISTFILE=~/.zsh_history

# Number of history lines to keep in memory for the current session
HISTSIZE=10000

# Number of history lines to save to the history file
SAVEHIST=10000

# Append new history lines to the history file (don't overwrite)
setopt APPEND_HISTORY
# Append commands to the history file immediately as they are executed
setopt INC_APPEND_HISTORY
# Share history between all running shells (imports new entries from file and exports session entries)
setopt SHARE_HISTORY
# Don't record duplicate commands if they are executed consecutively
setopt HIST_IGNORE_DUPS
# Don't record commands starting with a space
setopt HIST_IGNORE_SPACE
# Expire duplicate entries first when trimming history
setopt HIST_EXPIRE_DUPS_FIRST
# Don't write duplicate entries to the history file
setopt HIST_SAVE_NO_DUPS
# Remove blank lines from history
setopt HIST_REDUCE_BLANKS

# ------------------------------------------------------------------------------

function restart () {
  exec "$SHELL" -l
}

function newworktree () {
  repo=$(pwd | awk -F/ '{print $NF}')/$1
  git worktree add -b $1 ~/worktrees/${repo} ${2:-master}
  pushd ~/worktrees/${repo}
  nvim
}

function worktreeswitch () {
  worktree=$(git worktree list | awk '{print $1}' | fzf)
  pushd $worktree
}

function worktreeclean () {
  selection=$(git worktree list | awk '{print $1}' | fzf -m)
  while IFS= read -r s; do
    echo "Removing $s"
    git worktree remove $s
    rm -rf $s
  done <<< "$selection"
}

# Git
alias ws="worktreeswitch"
alias wc="worktreeclean"
alias checkout='git checkout $(git branch | fzf)'
alias gc="git commit"
alias ga="git add"
alias w="git worktree"
alias wl="git worktree list"
alias nw="newworktree"
alias master='git fetch origin master && git checkout master && git reset --hard origin/master && git pull'
alias branch='git checkout -b'
alias current_branch='git rev-parse --abbrev-ref HEAD'
alias commit='git commit -m'
alias push='git push -u origin "$(git rev-parse --abbrev-ref HEAD)"'
alias pr='gh pr create'
alias gitundo='git reset HEAD~'
alias prunebranches='git branch --merged | egrep -v "master" | xargs git branch -d && git branch | grep -v "master" | xargs git branch -D'
alias worktree='git worktree'
alias gl="git log --oneline | fzf --preview 'git show --color=always {1}'"
alias rebaseremote='git fetch origin master && git rebase origin/master && git push --force-with-lease'
alias rebase='git pull --rebase --autostash origin master'

# Kube
alias kc="kubectl"

# Terraform
alias tfinit="terraform init"
alias tfplan="terraform plan"
alias tfapply="terraform apply"
alias tfdestroy="terraform destroy"
alias tfvalidate="terraform validate"
alias tffmt="terraform fmt --recursive"

# Misc
alias tmux-setup="~/.scripts/tmux.sh"
alias tmux-kill="tmux kill-server"
alias cat="bat --theme=Dracula"
alias ls="eza -lah --icons --no-user"
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n' | pbcopy | echo 'UUID copied to clipboard'"

export PATH="$HOME/go/bin:$PATH"

eval "$(starship init zsh)"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
[ -f $HOMEBREW_PREFIX/etc/profile.d/autojump.sh ] && . $HOMEBREW_PREFIX/etc/profile.d/autojump.sh
eval "$(mcfly init zsh)"

