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
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export DOOMDIR="$HOME/.config/doom"
export EMACSDIR="$HOME/.config/emacs"
export HOMEBREW_NO_AUTO_UPDATE=1
export VULKAN_SDK="$HOME/VulkanSDK/vulkan/macOS"
export CMAKE_PREFIX_PATH="/opt/homebrew/opt/llvm"
# export LDFLAGS="-L$(brew --prefix zstd)/lib"
# export CPPFLAGS="-I$(brew --prefix zstd)/include"
# export PKG_CONFIG_PATH="$(brew --prefix zstd)/lib/pkgconfig"
export CMAKE_PREFIX_PATH="/opt/homebrew/opt/llvm"


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

####################### GIT ALIASES ################################################################
alias g='git'

alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gap='git apply'
alias gapt='git apply --3way'

alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gbg='git branch -vv | grep ": gone\]"'
alias gbgd='local res=$(gbg | awk '"'"'{print $1}'"'"') && [[ $res ]] && echo $res | xargs git branch -d'
alias gbgD='local res=$(gbg | awk '"'"'{print $1}'"'"') && [[ $res ]] && echo $res | xargs git branch -D'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias gc='git commit --verbose'
alias gc!='git commit --verbose --amend'
alias gcn!='git commit --verbose --no-edit --amend'
alias gca='git commit --verbose --all'
alias gca!='git commit --verbose --all --amend'
alias gcan!='git commit --verbose --all --no-edit --amend'
alias gcans!='git commit --verbose --all --signoff --no-edit --amend'
alias gcam='git commit --all --message'
alias gcsm='git commit --signoff --message'
alias gcas='git commit --all --signoff'
alias gcasm='git commit --all --signoff --message'
alias gcb='git checkout -b'
alias gcf='git config --list'

alias gcl='git clone --recurse-submodules'
alias gclean='git clean --interactive -d'
alias gpristine='git reset --hard && git clean --force -dfx'
alias gcmsg='git commit --message'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcount='git shortlog --summary --numbered'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit --gpg-sign'
alias gcss='git commit --gpg-sign --signoff'
alias gcssm='git commit --gpg-sign --signoff --message'

alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdw='git diff --word-diff'


alias gf='git fetch'
alias gfa='git fetch --all --prune --jobs=10'
alias gfo='git fetch origin'

alias gfg='git ls-files | grep'

alias gg='git gui citool'
alias gga='git gui citool --amend'

alias ghh='git help'

alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'

alias gk='\gitk --all --branches &!'
alias gke='\gitk --all $(git log --walk-reflogs --pretty=%h) &!'

alias gl='git pull'
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

alias gm='git merge'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
alias gma='git merge --abort'
alias gms="git merge --squash"

alias gp='git push'
alias gpd='git push --dry-run'
  alias gpf='git push --force-with-lease --force-if-includes'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpod='git push origin --delete'
alias gpr='git pull --rebase'
alias gpu='git push upstream'
alias gpv='git push --verbose'

alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grev='git revert'
alias grh='git reset'
alias grhh='git reset --hard'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grst='git restore --staged'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote --verbose'

alias gsb='git status --short --branch'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status --short'
alias gst='git status'

alias gsta='git stash push' 

alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gstu='gsta --include-untracked'
alias gstall='git stash --all'
alias gsu='git submodule update'
alias gsw='git switch'
alias gswc='git switch --create'

alias gts='git tag --sign'
alias gtv='git tag | sort -V'
alias gtl='gtl(){ git tag --sort=-v:refname -n --list "${1}*" }; noglob gtl'

alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git log --max-count=1 | grep -q -c "\--wip--" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupv='git pull --rebase --verbose'
alias gupa='git pull --rebase --autostash'
alias gupav='git pull --rebase --autostash --verbose'

alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'

alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'

alias gam='git am'
alias gamc='git am --continue'
alias gams='git am --skip'
alias gama='git am --abort'
alias gamscp='git am --show-current-patch'

####################################################################################################

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
