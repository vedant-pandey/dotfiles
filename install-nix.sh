#!/bin/bash

# Install Nix
curl -L https://nixos.org/nix/install > nix.sh
sh nix.sh --daemon --yes
rm ./nix.sh
# Enable Flakes
echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
# Restart shell
exec $SHELL
# Download Home-manager
nix run home-manager/master -- init
# Install Zap
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Clone repo
git clone https://github.com/vedant-pandey/dotfiles
cd ./dotfiles/home-manager
cp -r ./home-manager/.zshrc ~/.config/home-manager/
cp -r ./home-manager/.tmux.conf ~/.config/home-manager/
cp -r ./home-manager/home.nix ~/.config/home-manager/
cp -r ./home-manager/flake.lock ~/.config/home-manager/
# Init user config
nix eval --raw -f <(curl -L https://raw.githubusercontent.com/vedant-pandey/dotfiles/main/init-config.nix) > ~/.config/home-manager/user.toml
# Enable home-manager
home-manager switch
