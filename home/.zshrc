# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "wintermi/zsh-lsd"
plug "MAHcodes/distro-prompt"
plug "chivalryq/git-alias"
plug "zap-zsh/sudo"
# Load and initialise completion system
# autoload -Uz compinit
# compinit

export ANDROID_HOME="$HOME/Library/Android/sdk"
# PATH exports
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:/opt/apache-maven/bin"
export PATH="$PATH:$(brew --prefix llvm@15)/bin"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.flutter/bin"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"/Users/vedant/Library/Python/3.11/bin"
export GOPATH="$HOME/go"

export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home"
. "$HOME/.cargo/env"

export LDFLAGS="$LDFLAGS -L$(brew --prefix llvm@15)/lib"
export CPPFLAGS="$CPPFLAGS -I$(brew --prefix llvm@15)/include"
# bun completions
[ -s "/Users/vedant/.bun/_bun" ] && source "/Users/vedant/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export EDITOR='lvim'

# opam configuration
[[ ! -r /Users/vedant/.opam/opam-init/init.zsh ]] || source /Users/vedant/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey -e
alias y="yarn"
eval "$(fnm env --use-on-cd)"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home
alias vi=nvim

export PATH="$PATH:$GOPATH/bin"
export HOMEBREW_NO_ANALYTICS=1

bindkey -s "^f" "t-sesh\n"
bindkey -s "^g" "cheet\n"

[ -f "/Users/vedant/.ghcup/env" ] && source "/Users/vedant/.ghcup/env" # ghcup-env