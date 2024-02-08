{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "vedant";
    homeDirectory = "/Users/vedant";

    stateVersion = "23.11";

    packages = with pkgs; [
      stow
      # neovim
      # rustup
      lsd
      fnm
      lazygit
      fd
      # docker
      # java
      protobuf
      fswatch
      ripgrep
      gh
      glow
      jq
      parallel
      bat
      du-dust
      zig
    ];

    file = {
    };

    sessionVariables = {
    };
  };

  programs = {

    zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        autocd = true;
        defaultKeymap = "emacs";
        syntaxHighlighting.enable = true;
        history = {
            extended = true;
            ignoreAllDups = true;
            share = true;
            expireDuplicatesFirst = true;
        };
        historySubstringSearch = {
            enable = true;
        };
        initExtra = (builtins.readFile ./.zshrc);
    };

    tmux = {
        enable = true;
        prefix = "C-a";
        aggressiveResize = false;
        mouse = true;
        baseIndex = 1;
        plugins = with pkgs; [
            tmuxPlugins.sensible
            tmuxPlugins.logging
        ];
        extraConfig = (builtins.readFile ./.tmux.conf);
    };

    fzf = {
        enable = true;
        enableZshIntegration = true;
        fileWidgetCommand = "fd --type f";
    };

    git = {
        enable = true;
        delta = {
            enable = true;
        };
        ignores = [
            "vedanttest/"
        ];
        includes = [
        {
            contents = {
                push = {
                    autoSetupRemote = true;
                };
            };
        }
        {
            condition = "gitdir:~/personal/";
            contents = {
                user = {
                    name = "Vedant Pandey";
                    email = "vedantpandey46@gmail.com";
                };
                github = {
                    user = "vedant-pandey";
                };
                core = {
                    sshCommand = "ssh -i ~/.ssh/github-personal";
                };
            };
        }
        ];
    };
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
