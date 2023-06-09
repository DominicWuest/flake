{ config, pkgs, ... }:

let
  user = "dominic";
  system = "x86_64-linux";
in
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Storage optimization
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  networking.hostName = "onion";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zurich";

  fonts.fonts = with pkgs; [
    iosevka
    roboto-mono
    rPackages.fontawesome
    powerline-fonts
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  services.xserver.enable = true;

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.i3.enable = true;

  services.xserver.displayManager.defaultSession = "none+i3";


  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  services.urxvtd.enable = true;

  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
  };
  programs.tmux.enable = true;

  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    packages = with pkgs; [
      firefox
      tree
    ];
    shell = pkgs.zsh;
  };

  users.defaultUserShell = pkgs.zsh;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    htop
    wget
    git
    dconf
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

