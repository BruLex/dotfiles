# GIT aliases

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
GIT_COMPLETION_DIR=$SCRIPT_DIR/git-completion
GIT_COMPLETION_SCRIPT=$GIT_COMPLETION_DIR/.git-completion.bash
GIT_FLOW_COMPLETION_SCRIPT=$GIT_COMPLETION_DIR/.git-flow-completion.bash

if [ ! -d "$GIT_COMPLETION_DIR" ]; then
  mkdir -p $GIT_COMPLETION_DIR
fi

# Install auto completion
if [ ! -f "$GIT_COMPLETION_SCRIPT" ]; then
  wget -O "$GIT_COMPLETION_SCRIPT" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
fi

if [ ! -f "$GIT_FLOW_COMPLETION_SCRIPT" ]; then
  wget -O "$GIT_FLOW_COMPLETION_SCRIPT" https://raw.githubusercontent.com/petervanderdoes/git-flow-completion/develop/git-flow-completion.bash
fi

## Setup GIT aliases
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gcv='git commit'
alias gd='git diff'
alias gdd='git diff HEAD~1'
alias gds='git diff --stat'
alias gdds='git diff --stat HEAD~1'
alias go='git checkout'
alias get='git'
alias gf='git checkout -'

## Add auto completion to aliases
source "$GIT_COMPLETION_SCRIPT"

__git_complete gs _git_status
__git_complete ga _git_add
__git_complete gb _git_branch
__git_complete gc _git_commit
__git_complete gcv _git_commit
__git_complete gd _git_diff
__git_complete gdd _git_diff
__git_complete gds _git_diff
__git_complete gdds _git_diff
__git_complete go _git_checkout
__git_complete get _git_main
__git_complete gf _git_checkout

source "$GIT_FLOW_COMPLETION_SCRIPT"

alias gk='gitk --all&'
alias grh='git reset --hard HEAD~3 && git pull'
alias grr='git reset --hard HEAD~10'

# iPipeTo aliases
alias goi='git branch | ipt -a | xargs git checkout'
alias gbd='git branch | ipt -S 20 -m -M "Select branches to remove:" | xargs git branch -D'
alias gai='git status -s | sed s/^...// | ipt -S 20 -m -M "Select files to add:" | xargs git add'
