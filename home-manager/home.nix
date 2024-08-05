{ config, pkgs, ... }:

let 
userConfig = builtins.fromTOML (builtins.readFile ./user.toml);
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = userConfig.user;
    homeDirectory = userConfig.home;

    stateVersion = "23.11";

    packages = with pkgs; [
      stow
      graphviz
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
      postgresql
      go
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
        aggressiveResize = false;
        mouse = true;
        baseIndex = 1;
        keyMode = "vi";
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
            "out"
        ];
        includes = [
        {
            contents = {
                push = {
                    autoSetupRemote = true;
                };
                rerere = {
                    enabled = true;
                };
                column.ui = "auto";
                branch.sort = "-committerdate";
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

    neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
	extraLuaConfig = (builtins.readFile ./init.lua);
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
