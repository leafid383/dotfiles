# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Custom prompt
ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX="%{$fg[green]%}↑"
ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_COMMITS_BEHIND_PREFIX="%{$fg[red]%}↓"
ZSH_THEME_GIT_COMMITS_BEHIND_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

custom_prompt() {
  local repo=$(git_repo_name)
  if [[ -n "$repo" ]]; then
    local branch=$(git_current_branch)
    local ahead=$(git_commits_ahead)
    local behind=$(git_commits_behind)
    local dirty=$(parse_git_dirty)
    local info="${ahead}${behind}${dirty}"
    if [[ -z "$info" ]]; then
      info="%{$fg[blue]%}=%{$reset_color%}"
    fi
    echo "%{$fg[cyan]%}${repo}%{$reset_color%} %{$fg[magenta]%}${branch}%{$reset_color%}(${info})"
  else
    echo "%1~"
  fi
}

PROMPT='%(?.%{$fg[green]%}.%{$fg[red]%})→%{$reset_color%} $(custom_prompt): '
RPROMPT=''

# Aliases
alias gp="git pull"
alias gs="git switch"
alias gl="git log --oneline --graph"
alias v="nvim"
alias reload="source ~/.zshrc"

# git push with auto upstream
gps() {
  if git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
    git push
  else
    git push -u origin "$(git branch --show-current)"
  fi
}
