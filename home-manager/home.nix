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
      lua
      zsh-defer
      pandoc
      elixir
      qemu
      ansible
      stow
      graphviz
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
      tmux

      # ZSH config deps
      zsh-autosuggestions
      zsh-syntax-highlighting
      zsh-history-substring-search
    ];

    file = {
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/config/nvim";
        ".config/yabai".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/config/yabai";
        ".config/skhd".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/config/skhd";
        ".config/doom".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/config/doom";
        ".config/emacs".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/config/emacs";
        ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/home/.tmux.conf";
        ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/home/.zshrc";
        "bin/t-sesh".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/bin/t-sesh";
        "bin/cheet".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/bin/cheet";
    };

    sessionVariables = {
    };
  };

  programs = {
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
                    email = userConfig.personalEmail;
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
                    email = userConfig.email;
                };
                github = {
                    user = userConfig.githubUsername;
                };
                core = {
                    sshCommand = "ssh";
                };
                url."ssh://git.amazon.com".insteadOf = "https://git.amazon.com";
                ssh.variant = "ssh";
                credential.helper = "osxkeychain";
            };
        }
        {
            condition = "gitdir:~/ws/";
            contents = {
                user = {
                    name = userConfig.fullName;
                    email = userConfig.email;
                };
                github = {
                    user = userConfig.githubUsername;
                };
                core = {
                    sshCommand = "ssh";
                };
                url."ssh://git.amazon.com".insteadOf = "https://git.amazon.com";
                ssh.variant = "ssh";
                credential.helper = "osxkeychain";
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
