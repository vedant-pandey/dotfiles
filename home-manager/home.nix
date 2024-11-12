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

    stateVersion = "24.05";

    packages = with pkgs; [
      pandoc
      elixir
      qemu
      ansible
      stow
      graphviz
      lsd
      fnm
      lazygit
      fd
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
      cmake
      zig

      # ZSH config deps
      zsh-autosuggestions
      zsh-syntax-highlighting
      zsh-history-substring-search
    ];

    file = {
        ".config/nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/init.lua";
        ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/.zshrc";
    };

    sessionVariables = {
    };
  };

  programs = {

    # zsh = {
    #     enable = true;
    #     autosuggestion.enable = true;
    #
    #     enableCompletion = true;
    #     autocd = true;
    #     defaultKeymap = "emacs";
    #     syntaxHighlighting.enable = true;
    #     history = {
    #         extended = true;
    #         ignoreAllDups = true;
    #         share = true;
    #         expireDuplicatesFirst = true;
    #     };
    #     historySubstringSearch = {
    #         enable = true;
    #     };
    # };
    #
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
                init = {
                    defaultBranch = "main";
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
        {
            condition = "gitdir:~/work/";
            contents = {
                user = {
                    name = userConfig.fullName;
                    email = "";
                };
                github = {
                    user = userConfig.githubUsername;
                };
                core = {
                    sshCommand = "";
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
    };

    direnv = {
        enable = true;
        enableZshIntegration = true;
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
