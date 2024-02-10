# Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon --yes
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
# Enable home-manager
home-manager switch
