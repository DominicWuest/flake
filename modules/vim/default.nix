{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      vim
    ];

  home.file = {
    # vim
    ".vimrc" = {
      source = ../../dotfiles/vim;
    };
  };
}
