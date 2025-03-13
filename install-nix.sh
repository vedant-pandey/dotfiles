#!/bin/bash

# Setup base directories
echo "SETTING UP BASE DIRECTORIES"
if [[ -d "~/personal" ]]; then
    echo "Personal directory exists"
else
    echo "Creating personal directory"
    mkdir ~/personal
fi

if [[ -d "~/work" ]]; then
    echo "Work directory exists"
else
    echo "Creating work directory"
    mkdir ~/work
fi
cd ~/personal

echo "INSTALLING NIX"
curl -L https://nixos.org/nix/install > nix.sh
bash nix.sh --daemon --yes
rm ./nix.sh
echo "NIX INSTALLED"

echo "ENABLING NIX FLAKES"
sudo nix echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

source /etc/profile # reload shell

echo "INSTALLING HOME MANAGER"
nix run home-manager/master -- init --switch
# Install TPM
echo "INSTALLING TMUX PLUGIN MANAGER"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Clone repo
echo "CLONING DOTFILES"
git clone https://github.com/vedant-pandey/dotfiles
# Build user config

echo "BUILDING USER CONFIG FILE"
USER=${USER:-$(read -p "\$USER not set, Enter username: " envvalue && echo $envvalue)}
HOME=${HOME:-$(read -p "\$HOME not set, Enter home dir: " envvalue && echo $envvalue)}
GITHUB_USERNAME=${GITHUB_USERNAME:-$(read -p "\$GITHUB_USERNAME not set, Enter github username: " envvalue && echo $envvalue)}
WORK_EMAIL=${WORK_EMAIL:-$(read -p "\$WORK_EMAIL not set, Enter work email: " envvalue && echo $envvalue)}
PERSONAL_EMAIL=${PERSONAL_EMAIL:-$(read -p "\$PERSONAL_EMAIL not set, Enter personal email: " envvalue && echo $envvalue)}
FULL_NAME=${FULL_NAME:-$(read -p "\$FULL_NAME not set, Enter full name: " envvalue && echo $envvalue)}

cat > ./home-manager/user.toml << EOF
user = "$USER"
home = "$HOME"
githubUsername = "$GITHUB_USERNAME"
email = "$WORK_EMAIL"
personalEmail = "$PERSONAL_EMAIL"
fullName = "$FULL_NAME"
system = "aarch64-darwin"
EOF

echo "USER CONFIG FILE CREATED"
# Enable home-manager
echo "ENABLING NIX HOME MANAGER"
home-manager switch
echo "INSTALLING ZAP ZSH"
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
# Reload shell
echo "All installation done reload your environment by running \`exec \$SHELL\`"
