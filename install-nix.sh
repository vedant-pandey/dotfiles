# Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon
# Enable Flakes
echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
# Install Home-manager
nix run home-manager/master -- init --switch
# Install Zap
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
