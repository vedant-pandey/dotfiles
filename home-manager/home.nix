{ pkgs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home = {
        username = "vedant";
        homeDirectory = "/Users/vedant";

        stateVersion = "25.11";

        packages = with pkgs; [
            lua
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
            uv
			go
			bitwarden-cli
			notmuch
			tree-sitter
			isync
			msmtp
			w3m
			qpdf

			kubernetes-helm
			kubectl
			kind
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
			extraPackages = with pkgs; [
				gcc 
				tree-sitter
				nodejs
			];
        };

        direnv = {
            enable = true;
            enableZshIntegration = true;
        };

        # Let Home Manager install and manage itself.
        home-manager.enable = true;
    };
}
