{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      xcompmgr # transparency
      feh # set wallpapers
      xclip
      xsel # clipboard integration

      # Python and packages
      (python311.withPackages (ps: with ps; [
        # i3 bumblebee-status dependencies
        netifaces # for nic
        psutil # for cpu
        pulsectl # for pulseout
      ]))

      iw # i3 bumblebee-status nic dependency
    ];

  home.file = {
    # i3
    ".config/i3/config" = {
      source = ../../dotfiles/i3;
    };
    ".config/i3/bumblebee-status" = {
      source = builtins.fetchGit {
        url = "https://github.com/tobi-wan-kenobi/bumblebee-status.git";
        rev = "e5f36053aff760a1a9f3d9a7f48a21daccd412ae";
      };
      recursive = true;
    };
    "Pictures/wallpapers" = {
      source = ../../media/wallpapers;
      recursive = true;
    };
  };
}
