#!/bin/bash

# Install Nix
curl -L https://nixos.org/nix/install > nix.sh
bash nix.sh --daemon --yes
rm ./nix.sh
# Enable Flakes
echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
# Restart shell
source /etc/profile
# Download Home-manager
nix run home-manager/master -- init --switch
# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Clone repo
git clone https://github.com/vedant-pandey/dotfiles
cp -r ./dotfiles/home-manager/.zshrc ~/.config/home-manager/
cp -r ./dotfiles/home-manager/.tmux.conf ~/.config/home-manager/
cp -r ./dotfiles/home-manager/home.nix ~/.config/home-manager/
cp -r ./dotfiles/home-manager/flake.lock ~/.config/home-manager/
rm -rf ./dotfiles
# Init user config
curl -L https://raw.githubusercontent.com/vedant-pandey/dotfiles/main/init-config.nix > init-config.nix
nix eval --raw -f init-config.nix > ~/.config/home-manager/user.toml
rm init-config.nix
# Enable home-manager
home-manager switch
# Install Zap
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
