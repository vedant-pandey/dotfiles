{ pkgs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home = {
        username = "vedant";
        homeDirectory = "/Users/vedant";

        stateVersion = "24.11";

        packages = with pkgs; [
            lua
            zsh-defer
            pandoc
            elixir
            ansible
            stow
            graphviz
            fnm
            fd
            fswatch
            ripgrep
            gh
            glow
            jq
            parallel
            postgresql
            tmux
            nushell
            carapace
            lsd
            minisign
            gnupg
            git

            # ZSH config deps
            zsh-autosuggestions
            zsh-syntax-highlighting
            zsh-history-substring-search
        ];

    };

    programs = {
        fzf = {
            enable = true;
            enableZshIntegration = true;
            fileWidgetCommand = "fd --type f";
        };

        neovim = {
            enable = true;
            defaultEditor = true;
            viAlias = true;
            vimAlias = true;
        };

        direnv = {
            enable = true;
            enableZshIntegration = true;
        };

        # Let Home Manager install and manage itself.
        home-manager.enable = true;
    };
}
