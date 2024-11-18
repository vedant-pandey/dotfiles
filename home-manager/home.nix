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
        ".config/nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/init.lua";
        ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/.tmux.conf";
        ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/Users/${userConfig.user}/personal/dotfiles/home-manager/.zshrc";

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
