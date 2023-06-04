{ config, pkgs, ... }:

{
  home.username = "dominic";
  home.homeDirectory = "/home/dominic";

  home.stateVersion = "23.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    xcompmgr # transparency
    feh # set wallpapers
		xclip xsel # clipboard integration

    # zsh
    oh-my-zsh
    viu # Images in terminal

    # Python and packages
    ( python311.withPackages (ps: with ps; [
      # i3 bumblebee-status dependencies
      netifaces # for nic
      psutil    # for cpu
      pulsectl  # for pulseout
    ]))
  ];

	# VSCode
	programs.vscode = {
		enable = true;
		extensions = with pkgs.vscode-extensions; [
			eamodio.gitlens
			jdinhlife.gruvbox
			gruntfuggly.todo-tree
			vscodevim.vim
		# ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
		# 	{
		# 		name = "vscode-todo-highlight";
		# 		publisher = "wayou";
		# 		version = "1.0.5";
		# 		sha256 = "e5f36053aff760a1a9f3d9a7f48a21daccd412ae";
		# 	}
		];
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
    ".vimrc" = {
      source = ./dotfiles/vim;
    };

    # zsh
    ".zshrc" = {
      source = ./dotfiles/zsh;
    };
    "Pictures/potd" = { # Potd shown when starting shell
      source = ./media/potd;
      recursive = true;
    };
    "Pictures/wallpapers" = {
      source = ./media/wallpapers;
      recursive = true;
    };
    ".oh-my-custom/themes/agnoster-custom.zsh-theme" = { # Custom agnoster theme
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
