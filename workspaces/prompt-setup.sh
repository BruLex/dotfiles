# Custom prompt

# FMT_BOLD="\[\e[1m\]"
# FMT_DIM="\[\e[2m\]"
# FMT_RESET="\[\e[0m\]"
# FMT_UNBOLD="\[\e[22m\]"
# FMT_UNDIM="\[\e[22m\]"
# FG_BLACK="\[\e[30m\]"
# FG_BLUE="\[\e[34m\]"
# FG_CYAN="\[\e[36m\]"
# FG_GREEN="\[\e[32m\]"
# FG_GREY="\[\e[37m\]"
# FG_MAGENTA="\[\e[35m\]"
# FG_RED="\[\e[31m\]"
# FG_WHITE="\[\e[97m\]"
# BG_BLACK="\[\e[40m\]"
# BG_BLUE="\[\e[44m\]"
# BG_CYAN="\[\e[46m\]"
# BG_GREEN="\[\e[42m\]"
# BG_MAGENTA="\[\e[45m\]"

# PS1="\n${FG_BLUE}" # begin arrow to prompt
# PS1+="${BG_CYAN}${FG_BLACK} \u" # print username
# PS1+="${FG_CYAN}${BG_CYAN}${BG_BLUE} " # end USERNAME container / begin DIRECTORY container
# PS1+="${FG_BLACK}\w " # print directory
# PS1+="${FG_BLUE}${BG_CYAN} " # end DIRECTORY container / begin FILES container
# PS1+="${FG_BLACK}"
# PS1+=" \$(find . -mindepth 1 -maxdepth 1 -type d | wc -l) " # print number of folders
# PS1+=" \$(find . -mindepth 1 -maxdepth 1 -type f | wc -l) " # print number of files
# PS1+=" \$(find . -mindepth 1 -maxdepth 1 -type l | wc -l) " # print number of symlinks
# PS1+="${FMT_RESET}${FG_CYAN}"
# PS1+="\$(git branch 2> /dev/null | grep '^*' | colrm 1 2 | xargs -I BRANCH echo -n \"" # check if git branch exists
# PS1+="${BG_GREEN} " # end FILES container / begin BRANCH container
# PS1+="${FG_WHITE} BRANCH " # print current git branch
# PS1+="${FMT_RESET}${FG_GREEN}\")\n " # end last container (either FILES or BRANCH)
# PS1+="${FG_CYAN}\\$ " # print prompt
# PS1+="${FMT_RESET}"
# export PS1

# Starship Section

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

export STARSHIP_CONFIG=$SCRIPT_DIR/starship/brulex-starship-theme.toml
eval "$(starship init bash)"