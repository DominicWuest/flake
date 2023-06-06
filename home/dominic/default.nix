{ config, pkgs, ... }@input:

let
  user = "dominic";
  moduleInput = input // {
    user = user;
  };
in
{
  home.username = "dominic";
  home.homeDirectory = "/home/dominic";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  imports = [
    (import ../../modules/i3 moduleInput)
    (import ../../modules/tmux moduleInput)
    (import ../../modules/zsh moduleInput)
    (import ../../modules/vim moduleInput)
    (import ../../modules/firefox moduleInput)
    (import ../../modules/vscode moduleInput)
    (import ../../modules/go moduleInput)
  ];

  home.packages = with pkgs;
    [
      # TODO: Where to put this...
      nixpkgs-fmt

      slack
      discord
      thunderbird
    ];
}
