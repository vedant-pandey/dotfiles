##################### HOME MANAGER CONFIG COPY START ##############################################
# Enable autosuggestions
if [ -f /nix/store/*-zsh-autosuggestions*/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /nix/store/*-zsh-autosuggestions*/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Enable syntax highlighting
if [ -f /nix/store/*-zsh-syntax-highlighting*/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /nix/store/*-zsh-syntax-highlighting*/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Enable substring history search
if [ -f /nix/store/*-zsh-history-substring-search*/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
    source /nix/store/*-zsh-history-substring-search*/share/zsh-history-substring-search/zsh-history-substring-search.zsh

fi

# Enable completion
autoload -U compinit && compinit

# Enable autocd
setopt autocd

# Set keymap
bindkey -e  # This sets emacs keymap

# History settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY          # Write timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_ALL_DUPS     # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS        # Do not display a line previously found
setopt HIST_SAVE_NO_DUPS        # Don't write duplicate entries in the history file
setopt SHARE_HISTORY            # Share history between all sessions

##################### HOME MANAGER CONFIG COPY END ################################################


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
export PATH="$PATH:$(brew --prefix llvm)/bin"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/bin/zig"
export PATH="$PATH:$HOME/.flutter/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"/Users/vedant/Library/Python/3.11/bin"
export PATH="$PATH":"/usr/local/go/bin"
export PATH="$PATH":"$(which zig)"

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home"

export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

# opam configuration
[[ ! -r /Users/vedant/.opam/opam-init/init.zsh ]] || source /Users/vedant/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
[[ ! -r '/Users/pandveda/.opam/opam-init/init.zsh' ]] || source '/Users/pandveda/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null

alias y="yarn"

export HOMEBREW_NO_ANALYTICS=1

bindkey -s "^f" "t-sesh\n"
bindkey -s "^g" "nvim .\n"
bindkey -s "^h" "home-manager switch --show-trace\n"

eval "$(fnm env --use-on-cd)"

[ -f "/Users/vedant/.ghcup/env" ] && source "/Users/vedant/.ghcup/env" # ghcup-env
eval "$(/opt/homebrew/bin/brew shellenv)"
if [ -e /home/pandveda/.nix-profile/etc/profile.d/nix.sh ]; then . /home/pandveda/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# You probably also want to add Nix to your path:
export PATH=$HOME/.nix-profile/bin:$PATH

# If you plan to use home-manager, it may also be required to set NIX_PATH
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/$USER/channels${NIX_PATH:+:$NIX_PATH}
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

####################################### WORK DEPS START ###########################################

if command -v ninja-dev-sync >/dev/null 2>&1; then
    alias nds="ninja-dev-sync"
fi

if command -v brazil-build >/dev/null 2>&1; then
    alias bb=brazil-build
    alias bba='brazil-build apollo-pkg'
    alias bre='brazil-runtime-exec'
    alias brc='brazil-recursive-cmd'
    alias bws='brazil ws'
    alias bwsuse='bws use --gitMode -p'
    alias bwscreate='bws create -n'
fi

if command -v brazil-recursive-cmd >/dev/null 2>&1; then
    alias brc=brazil-recursive-cmd
    alias bbr='brc brazil-build'
    alias bball='brc --allPackages'
    alias bbb='brc --allPackages brazil-build'
    alias bbc='brc --allPackages brazil-build clean'
    alias bbra='bbr apollo-pkg'
fi

if command -v tmux >/dev/null 2>&1; then
    alias ta='tmux a'
fi

if command -v eda >/dev/null 2>&1; then
    alias erg='eda run git'
fi

alias dsk="ssh devdesk"

####################################### WORK DEPS END #############################################
