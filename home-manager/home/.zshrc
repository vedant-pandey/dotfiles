# Profile zsh startup
# zmodload zsh/zprof

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Essential environment variables
export ANDROID_HOME="$HOME/Library/Android/sdk"
export GOPATH="$HOME/go"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home"
export HOMEBREW_NO_ANALYTICS=1
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include -I/opt/homebrew/opt/openjdk@17/include"
export DOOMDIR="$HOME/.config/doom"
export EMACSDIR="$HOME/.config/emacs"
export HOMEBREW_NO_AUTO_UPDATE=1
export VULKAN_SDK="$HOME/VulkanSDK/vulkan/macOS"

# Early initialization of critical components
typeset -U path

# Define paths statically
path=(
    $HOME/.nix-profile/bin
    $HOME/Library/Android/sdk/platform-tools
    $HOME/Library/Python/3.11/bin
    $HOME/.flutter/bin
    $HOME/.pub-cache/bin
    $HOME/go/bin
    $HOME/bin
    $HOME/bin/zig
    /usr/local/go/bin
    $path
    $HOME/.emacs.d/bin
    $EMACSDIR/bin
    $HOME/.toolbox/bin
    /opt/homebrew/opt/openjdk@11/bin
    /opt/homebrew/opt/llvm/bin
    /opt/homebrew/opt/grep/libexec/gnubin
    $HOME/.
    /opt/homebrew/opt/openjdk@17/bin
    $HOME/personal/opensource/Odin
	$VULKAN_SDK/bin
)
export PATH

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

# History configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
unsetopt BEEP
setopt AUTO_CD
setopt GLOB_DOTS
setopt NOMATCH
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_ALL_DUPS 
setopt HIST_IGNORE_SPACE HIST_REDUCE_BLANKS HIST_VERIFY               
setopt HIST_FIND_NO_DUPS HIST_SAVE_NO_DUPS SHARE_HISTORY HIST_IGNORE_DUPS autocd

export DYLD_LIBRARY_PATH="$VULKAN_SDK/lib:$DYLD_LIBRARY_PATH"
export VK_ICD_FILENAMES="$VULKAN_SDK/share/vulkan/icd.d/MoltenVK_icd.json"
export VK_LAYER_PATH="$VULKAN_SDK/share/vulkan/explicit_layer.d"

eval "$(command fnm env --use-on-cd)"


# Custom backward-kill-word that stops at forward slashes and dots
backward-kill-word-boundaries() {
    local WORDCHARS_ORIGINAL="$WORDCHARS"
    # Remove '/' and '.' from WORDCHARS so they're treated as word boundaries
    WORDCHARS="${WORDCHARS//\//}"
    WORDCHARS="${WORDCHARS//\./}"
    zle backward-kill-word
    WORDCHARS="$WORDCHARS_ORIGINAL"
}

# Register the custom function as a zle widget
zle -N backward-kill-word-boundaries

# Bind Option+Backspace to the custom function (stops at / and .)
bindkey '^[^H' backward-kill-word-boundaries
bindkey '^[^?' backward-kill-word-boundaries

bindkey '^W' backward-kill-word

source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load

# Basic keybindings
bindkey -e
bindkey -s "^f" "t-sesh\n"
bindkey -s "^g" "nvim .\n"
bindkey -s "^h" "home-manager switch --show-trace\n"

alias y="yarn"
alias ta='tmux a'
alias dsk="ssh devdesk"
alias ls='lsd'
alias la="ls -a"
alias ll="ls -la"
alias lt="ls --tree"
alias gst='git status'
alias gl='git pull'

gomodauto() {
    echo "$(grv | head -1 | awk '{print $2}' | cut -d'@' -f2 | tr ':' '/' | cut -d'.' -f-2)/$(git rev-parse --show-prefix)" | sed 's:/*$::' | xargs -I{} go mod init {}
}
tunnel_dsk() {
    ssh devdesk -v -N -L "$1":localhost:"$1"
} 

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
source <(fzf --zsh)

[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then 
    . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/$USER/channels${NIX_PATH:+:$NIX_PATH}

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zprof > /tmp/zsh_profile.log
