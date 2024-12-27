export PATH export STARSHIP_CONFIG=~/.config/starship.toml # NOTE: Keep this at the top of all other functiions or the grep/awk combo won't work corectly
function list_aliases () {
  local NOCOLOUR=$(tput sgr0)
  local RED=$(tput setaf 1)
  local GREEN=$(tput setaf 2)
  local PINK=$(tput setaf 5)
  local YELLOW=$(tput setaf 3)
  local UNDERLINE_START=$(tput smul)
  local UNDERLINE_END=$(tput rmul)

  # Print table header
  printf "${YELLOW}${UNDERLINE_START}%-20s %-50s ${UNDERLINE_END}${NOCOLOUR}\n" "Type" "Definition"

  grep 'alias' ~/.zshrc | tail -n +5 | awk '{print $2}' | cut -d= -f1 | while read -r alias_name; do
    printf "${GREEN}%-20s %-50s ${NOCOLOUR}\n" "Alias" "${alias_name}"
  done

  grep 'function' ~/.zshrc | awk 'NR!=2' | awk '{print $2}' | while read -r func_name; do
    printf "${PINK}%-20s %-50s ${NOCOLOUR}\n" "Function" "${func_name}"
  done
}

function restart () {
  exec "$SHELL" -l
}

# code workaround for vscode
function code () { 
  VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;
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

# function j() {
#     local preview_cmd="ls {2..}"
#     if command -v exa &> /dev/null; then
#         preview_cmd="exa -l {2}"
#     fi
#
#     if [[ $# -eq 0 ]]; then
#                  cd "$(autojump -s | sort -k1gr | awk -F : '$1 ~ /[0-9]/ && $2 ~ /^\s*\// {print $1 $2}' | fzf --height 40% --reverse --inline-info --preview "$preview_cmd" --preview-window down:50% | cut -d$'\t' -f2- | sed 's/^\s*//')"
#     else
#         cd $(autojump $@)
#     fi
# }

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
