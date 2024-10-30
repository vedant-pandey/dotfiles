# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "wintermi/zsh-lsd"
plug "MAHcodes/distro-prompt"
plug "chivalryq/git-alias"
plug "zap-zsh/sudo"
# Load and initialise completion system
# autoload -Uz compinit
# compinit

bindkey -e

export ANDROID_HOME="$HOME/Library/Android/sdk"
# PATH exports
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:/opt/apache-maven/bin"
<<<<<<< HEAD
export PATH="$PATH:$(brew --prefix llvm@15)/bin"
=======
export PATH="$PATH:$(brew --prefix llvm)/bin"
export PATH="$BUN_INSTALL/bin:$PATH"
>>>>>>> 11cbacd (fix: cleaning up configs)
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/bin/zig"
export PATH="$PATH:$HOME/.flutter/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"/Users/vedant/Library/Python/3.11/bin"
export PATH="$PATH":"/usr/local/go/bin"
export PATH="$PATH":"$(which zig)"
# export PATH="$PATH:$(dirname (which elixir))"

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home"
# . "$HOME/.cargo/env"

export LDFLAGS="$LDFLAGS -L$(brew --prefix llvm)/lib"
export CPPFLAGS="$CPPFLAGS -I$(brew --prefix llvm)/include"
# bun completions
# [ -s "/Users/vedant/.bun/_bun" ] && source "/Users/vedant/.bun/_bun"

# opam configuration
[[ ! -r /Users/vedant/.opam/opam-init/init.zsh ]] || source /Users/vedant/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

alias y="yarn"

export HOMEBREW_NO_ANALYTICS=1

bindkey -s "^f" "t-sesh\n"
bindkey -s "^g" "nvim .\n"
bindkey -s "^h" "home-manager switch --show-trace\n"

eval "$(fnm env --use-on-cd)"

[ -f "/Users/vedant/.ghcup/env" ] && source "/Users/vedant/.ghcup/env" # ghcup-env
eval "$(/opt/homebrew/bin/brew shellenv)"
if [ -e /home/pandveda/.nix-profile/etc/profile.d/nix.sh ]; then . /home/pandveda/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi


# You probably also want to add Nix to your path:
export PATH=$HOME/.nix-profile/bin:$PATH

# If you plan to use home-manager, it may also be required to set NIX_PATH
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/$USER/channels${NIX_PATH:+:$NIX_PATH}
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
