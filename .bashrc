# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias watch='watch --color'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# prompt
FMT_BOLD="\[\e[1m\]"
FMT_DIM="\[\e[2m\]"
FMT_RESET="\[\e[0m\]"
FMT_UNBOLD="\[\e[22m\]"
FMT_UNDIM="\[\e[22m\]"
FG_BLACK="\[\e[30m\]"
FG_BLUE="\[\e[34m\]"
FG_CYAN="\[\e[36m\]"
FG_GREEN="\[\e[32m\]"
FG_GREY="\[\e[37m\]"
FG_MAGENTA="\[\e[35m\]"
FG_RED="\[\e[31m\]"
FG_WHITE="\[\e[97m\]"
BG_BLACK="\[\e[40m\]"
BG_BLUE="\[\e[44m\]"
BG_CYAN="\[\e[46m\]"
BG_GREEN="\[\e[42m\]"
BG_MAGENTA="\[\e[45m\]"

PS1="\n${FG_BLUE}" # begin arrow to prompt
PS1+="${BG_CYAN}${FG_BLACK} \u" # print username
PS1+="${FG_CYAN}${BG_CYAN}${BG_BLUE} " # end USERNAME container / begin DIRECTORY container
PS1+="${FG_BLACK}\w " # print directory
PS1+="${FG_BLUE}${BG_CYAN} " # end DIRECTORY container / begin FILES container
PS1+="${FG_BLACK}"
PS1+=" \$(find . -mindepth 1 -maxdepth 1 -type d | wc -l) " # print number of folders
PS1+=" \$(find . -mindepth 1 -maxdepth 1 -type f | wc -l) " # print number of files
PS1+=" \$(find . -mindepth 1 -maxdepth 1 -type l | wc -l) " # print number of symlinks
PS1+="${FMT_RESET}${FG_CYAN}"
PS1+="\$(git branch 2> /dev/null | grep '^*' | colrm 1 2 | xargs -I BRANCH echo -n \"" # check if git branch exists
PS1+="${BG_GREEN} " # end FILES container / begin BRANCH container
PS1+="${FG_WHITE} BRANCH " # print current git branch
PS1+="${FMT_RESET}${FG_GREEN}\")\n " # end last container (either FILES or BRANCH)
PS1+="${FG_CYAN}\\$ " # print prompt
PS1+="${FMT_RESET}"
export PS1


# GIT aliases

# Install auto completion
if [ ! -f ~/.git-completion.bash ]; then
  wget -O ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash  
fi

if [ ! -f ~/.git-flow-completion.bash ]; then
  wget -O ~/.git-flow-completion.bash https://raw.githubusercontent.com/petervanderdoes/git-flow-completion/develop/git-flow-completion.bash    
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
source ~/.git-completion.bash
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
source ~/.git-flow-completion.bash

alias gk='gitk --all&'
alias grh='git reset --hard HEAD~3 && git pull'
alias grr='git reset --hard HEAD~10'

# iPipeTo aliases
alias goi='git branch | ipt -a | xargs git checkout'
alias gbd='git branch | ipt -S 20 -m -M "Select branches to remove:" | xargs git branch -D'
alias gai='git status -s | sed s/^...// | ipt -S 20 -m -M "Select files to add:" | xargs git add'
alias sc='ntl -i -a -A'

# workspaces aliases
alias cdp='cd ~/projects'
alias cdw='cd ~/work'

alias ff='printf "src/app/shop/services/checkout-guard/checkout-guard.service.ts\nsrc/app/shop/services/checkout-step-check-guard/checkout-step-check-guard.service.ts\nsrc/app/shop/services/common-payment-billing/common-payment-billing.service.ts\nsrc/app/shop/services/digital-library/digital-library.service.ts\nsrc/app/shop/services/edition-pricing-resolver/edition-pricing-resolver.service.ts\nsrc/app/shop/services/editions-pricing/editions-pricing.service.ts\nsrc/app/shop/services/external-cart-utils/external-cart-utils.service.ts\nsrc/app/shop/services/subscription-utils/subscription-utils.service.ts"'

alias drop_cache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR=nano
export PATH="$PATH:$(yarn global bin)"

clear

source $(dirname $(gem which colorls))/tab_complete.sh

# colorls Section
alias ls='colorls '
alias lc='colorls -lA --sd'
alias ll='lc'

eval "$(/root/.nvm/versions/node/v14.17.0/bin/direnv hook bash)"

# Starship Section
export STARSHIP_CONFIG=/root/brulex-starship-theme.toml
# export STARSHIP_CONFIG=/root/nerd-font-symbols.toml
# export STARSHIP_CONFIG=/root/bracketed-segments.toml

eval "$(starship init bash)"


# export HUSKY_SKIP_HOOKS=1
