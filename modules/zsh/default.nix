{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      oh-my-zsh
      viu # Images in terminal
    ];

  home.file = {
    ".zshrc" = {
      source = ../../dotfiles/zsh;
    };
    "Pictures/potd" = {
      # Potd shown when starting shell
      source = ../../media/potd;
      recursive = true;
    };
    ".oh-my-custom/themes/agnoster-custom.zsh-theme" = {
      # Custom agnoster theme
      source = ../../dotfiles/zsh-theme;
    };
  };

  programs.zsh = {
    enable = false; # Already enabled globally
    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };
}
