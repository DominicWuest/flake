{ config, pkgs, ... }:

{
  home.username = "dominic";
  home.homeDirectory = "/home/dominic";

  home.stateVersion = "23.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # zsh
    oh-my-zsh
    viu # Images in terminal

    # Python and packages
    (python311.withPackages(ps: with ps; [
      # i3 bumblebee-status dependencies
      netifaces # for nic
      psutil    # for cpu
      pulsectl  # for pulseout
    ]))

    (writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.file = {
    # i3
    ".config/i3/config" = {
      source = ./dotfiles/i3;
    };
    ".config/i3/bumblebee-status" = {
      source = builtins.fetchGit {
        url = "https://github.com/tobi-wan-kenobi/bumblebee-status.git";
        rev = "e5f36053aff760a1a9f3d9a7f48a21daccd412ae";
      };
      recursive = true;
    };

    # vim

    # zsh
    ".zshrc" = {
      source = ./dotfiles/zsh;
    };
    "Pictures/potd" = {
      source = ./media/potd;
      recursive = true;
    };
    # Custom zsh agnoster theme
    ".oh-my-custom/themes/agnoster-custom.zsh-theme" = {
      source = ./dotfiles/zsh-theme;
    };

  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ( ./dotfiles/tmux );
    plugins = with pkgs; [
      # Resurrect plugin
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
        set -g @resurrect-strategy-vim 'session'
        set -g @resurrect-capture-pane-contents 'on'
        '';
      }

      # Continuum plugin
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '5'
        '';
      }

      # Gruvbox plugin
      {
        plugin = tmuxPlugins.gruvbox;
        extraConfig = "set -g @tmux-gruvbox 'dark'";
      }
    ];
  };

  xresources.extraConfig = builtins.readFile ( ./dotfiles/Xresources );

  programs.go.enable = true;

  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
    TERM = "tmux";
  };

  programs.home-manager.enable = true;
}
