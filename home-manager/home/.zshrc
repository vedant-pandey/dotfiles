# Profile zsh startup
# zmodload zsh/zprof

# Skip global compinit on startup
skip_global_compinit=1

# Essential environment variables
export ANDROID_HOME="$HOME/Library/Android/sdk"
export GOPATH="$HOME/go"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home"
export HOMEBREW_NO_ANALYTICS=1
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include -I/opt/homebrew/opt/openjdk@10/include"
export DOOMDIR="$HOME/.config/doom"
export EMACSDIR="$HOME/.config/emacs"

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
)
export PATH

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

# History configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_ALL_DUPS 
setopt HIST_FIND_NO_DUPS HIST_SAVE_NO_DUPS SHARE_HISTORY autocd


# Lazy load fnm
# fnm() {
#     unset -f fnm
    eval "$(command fnm env --use-on-cd)"
#     fnm "$@"
# }

# Lazy load brew
brew() {
    unset -f brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew "$@"
}

# Load essential Nix plugins with optimization flags
if [ -f /nix/store/*-zsh-autosuggestions*/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /nix/store/*-zsh-autosuggestions*/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_MANUAL_REBIND=1
    ZSH_AUTOSUGGEST_USE_ASYNC=1
fi

# Load Zap and prompt-related plugins immediately
if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ]; then
    source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
fi

# Defer syntax highlighting (it's one of the slowest)
if [ -f /nix/store/*zsh-defer*/share/zsh-defer/zsh-defer.plugin.zsh ]; then
    source /nix/store/*zsh-defer*/share/zsh-defer/zsh-defer.plugin.zsh
    
    # Defer syntax highlighting load
    zsh-defer source /nix/store/*-zsh-syntax-highlighting*/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    
    # Defer history substring search (depends on syntax highlighting)
    zsh-defer source /nix/store/*-zsh-history-substring-search*/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    
    # Defer Zap loading
fi

source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug 'zap-zsh/supercharge'
plug 'chivalryq/git-alias'

# Basic keybindings
bindkey -e
bindkey -s "^f" "t-sesh\n"
bindkey -s "^g" "nvim .\n"
bindkey -s "^h" "home-manager switch --show-trace\n"

###################################################################################################
alias y="yarn"
alias ta='tmux a'
alias dsk="ssh devdesk"
alias emc="emacsclient -c -a 'emacs'"
alias ls='lsd'
alias la="ls -a"
alias ll="ls -la"
alias lt="ls --tree"
alias nds="ninja-dev-sync"
alias bb=brazil-build
alias bba='brazil-build apollo-pkg'
alias bre='brazil-runtime-exec'
alias brc='brazil-recursive-cmd'
alias bws='brazil ws'
alias bwsuse='bws use --gitMode -p'
alias bwscreate='bws create -n'
alias erg='eda run git'
alias bbr='brc brazil-build'
alias bball='brc --allPackages'
alias bbb='brc --allPackages brazil-build'
alias bbc='brc --allPackages brazil-build clean'
alias bbra='bbr apollo-pkg'
alias eauth=' eauth'
tunnel_dsk() {
    ssh devdesk -v -N -L "$1":localhost:"$1"
} 
ddir() {
    echo $1 | tr '/' ' ' | cut -d' ' -f3,5 | tr ' ' '/' | awk '{print "/local/home/"$1}'
}
dpwd() {
    pwd | tr '/' ' ' | cut -d' ' -f3,5 | tr ' ' '/' | awk '{print "/local/home/"$1}'
}
synconce() {
    simulation_mode=false

    while getopts ":n" opt; do
        case ${opt} in
            n )
                simulation_mode=true
                ;;
        esac
    done

    if [[ "$simulation_mode" = true ]]; then
        echo "NOT ACTUALLY SYNCING"
        rsync -rlzptvn --exclude '**/build/' --exclude 'tmp' --exclude 'logs' --exclude 'env' --exclude '.idea' --exclude '.bemol' --exclude '.brazil*' ./ pandveda@devdesk:$(dpwd)
    else
        echo "ACTUALLY SYNCING"
        rsync -rlzptvn --exclude '**/build/' --exclude 'tmp' --exclude 'logs' --exclude 'env' --exclude '.idea' --exclude '.bemol' --exclude '.brazil*' ./ pandveda@devdesk:$(dpwd)
    fi

}


export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
    
###################################################################################################

source <(fzf --zsh)

# Defer OPAM initialization
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then 
    . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/$USER/channels${NIX_PATH:+:$NIX_PATH}

########################### PROMPT STYLE START ####################################################

autoload -Uz vcs_info
autoload -U colors && colors
zstyle ':vcs_info:*' enable git 

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst


zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})%{$reset_color%}"

OS=$(uname -or)

case $OS in
    *Darwin*) ICON="" ;;
    *Android*) ICON="" ;;
    *microsoft*) ICON="" ;;
    *BSD*) 
      DISTRO=$(uname -s)
      case $DISTRO in
        *FreeBSD*) ICON="" ;;
        *OpenBSD*) ICON="" ;;
      esac
    ;;
    *Linux*) 
      DISTRO=$(awk -F= '/^ID=/ {print $2}' /etc/os-release 2> /dev/null | sed 's/"//g')
      case $DISTRO in
        arch|archarm) ICON="" ;;
        void) ICON="" ;;
        centos) ICON="" ;;
        ubuntu) ICON="" ;;
        fedora) ICON="" ;;
        alpine) ICON="" ;;
        artix) ICON="" ;;
        gentoo) ICON="" ;;
        debian) ICON="" ;;
        linuxmint) ICON="" ;;
        manjaro) ICON="" ;;
        pop) ICON="" ;;
        parrot) ICON="" ;;
        kali) ICON="" ;;
        guix) ICON="" ;;
        nixos) ICON="" ;;
        endeavouros) ICON="" ;;
        deepin) ICON="" ;;
        archlabs) ICON="" ;;
        almalinux) ICON="" ;;
        raspbian) ICON="" ;;
        rhel) ICON="" ;;
        slackware) ICON="" ;;
        zorin) ICON="" ;;
        elementary) ICON="" ;;
        solus) ICON="" ;;
        rocky) ICON="" ;;
        opensuse*) ICON="" ;;
        *) ICON="" ;;
      esac
      ;;
    *) ICON="" ;;
esac


PROMPT="%B%{$fg_bold[black]%} $ICON % %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$fg[blue]%}%c%{$reset_color%}"
PROMPT+="\$vcs_info_msg_0_ "
########################### PROMPT STYLE END ######################################################


########################### WORK PLUGINS START ####################################################
# Set up mise for runtime management
zsh-defer eval "$(mise activate zsh)"
########################### WORK PLUGINS END ######################################################

# zprof > /tmp/zsh_profile.log
