{ config, pkgs, ... }:

{
#  # Home Manager is pretty good at managing dotfiles. The primary way to manage
#  # plain files is through 'home.file'.
#  home.file = {
#    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
#    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
#    # # symlink to the Nix store copy.
#    # ".screenrc".source = dotfiles/screenrc;
#
#    # # You can also set the file content immediately.
#    # ".gradle/gradle.properties".text = ''
#    #   org.gradle.console=verbose
#    #   org.gradle.daemon.idletimeout=3600000
#    # '';
#  };
#

  home = {
    username = "root";
    homeDirectory = "/root";
    stateVersion = "22.11";

    packages = with pkgs; [
      stow
      tmux
      rustup
      # unable to find zap-zsh
      lsd
      fnm
      lazygit
      # install tmux plugin manager(tpm)
      fd
      ripgrep
      # docker wrapper for nix
      gh
      glow
      jq
      parallel
      bat
      kubernetes
      xclip
    ];

    sessionVariables = {
    };
  };

  programs = {
      zsh = {
          enable = true;
          initExtra = ''
            bindkey -e
          '';
      };

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

      home-manager.enable = true;
  };

}
