# Creates symlinks to dotfiles folder and install all required applications
BOLD="$(tput bold 2>/dev/null || printf '')"
GREY="$(tput setaf 0 2>/dev/null || printf '')"
UNDERLINE="$(tput smul 2>/dev/null || printf '')"
RED="$(tput setaf 1 2>/dev/null || printf '')"
GREEN="$(tput setaf 2 2>/dev/null || printf '')"
YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
BLUE="$(tput setaf 4 2>/dev/null || printf '')"
MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
NODE_VERSION=14

info() {
    printf '%s\n' "${BOLD}${GREY}>${GREEN} $*${NO_COLOR}"
}

sp="/-\|"
sc=0
spin() {
    printf "\b${sp:sc++:1}"
    ((sc == ${#sp})) && sc=0
}
endspin() {
    printf "\r%s\n" "$@"
}

# Install nvm
info "Instaling NVM..."
rm -rf "$HOME/.nvm"

export NVM_DIR="$HOME/.nvm"

git clone --quiet https://github.com/nvm-sh/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout --quiet $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)) >/dev/null
\. "$NVM_DIR/nvm.sh" >/dev/null

# Install Starship
info "Instaling Starship..."
curl -sS https://starship.rs/install.sh >/tmp/starship-install.sh
chmod +x /tmp/starship-install.sh
/tmp/starship-install.sh -y >/dev/null
rm -f /tmp/starship-install.sh

# Link repo files
FILES_TO_LINK=(.profile .bashrc .gitconfig .nirc .nvm/default-packages .angular-config.json workspaces)
info "Removing and linking files in user space..."

for item in ${FILES_TO_LINK[*]}; do
    rm -rf ~/$item
    ln -s $SCRIPT_DIR/$item ~/$item
    printf "\t$SCRIPT_DIR/$item -> ~/$item\n"
done

info "Instaling NodeJS $NODE_VERSION via NVM..."
nvm install $NODE_VERSION >/dev/null

info "NVM: Created default alias for NodeJS $NODE_VERSION"
nvm use default $NODE_VERSION >/dev/null

info "NVM: Set current NodeJS version as $NODE_VERSION"
nvm use $NODE_VERSION >/dev/null

info "Instaling direnv..."
curl -sfL https://direnv.net/install.sh | bash &>/dev/null

info "Installing ruby..."
sudo apt-get install -y ruby-full >/dev/null

info "Installing colorls..."
gem install colorls >/dev/null
