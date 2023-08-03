# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# install stow
# install neovim
# install tmux
# install rustup
# install zap
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
# install lsd
# install nerd fonts
# install fnm && node 
# install lazygit
# install lunar vim
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# install fd
cargo install fd-find
# install rip grep
cargo install ripgrep
# install docker
# install gh
brew install gh
# install java
# install gradle
# install yabai
brew install koekeishiya/formulae/yabai
# install skhd
brew install koekeishiya/formulae/skhd
# install glow
brew install glow
# install jq
brew install jq
# install proto buffers
brew install protobuf
# fswatch(live reload)
brew install fswatch
# install GNU parallel
brew install parallel
# install obsidian
# install grpc dependencies
 go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
 go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
# Install bat
cargo install --locked bat
# install haskell
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
#
