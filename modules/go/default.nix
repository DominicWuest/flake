{ pkgs, user, ... }:

{
  home.packages = with pkgs;
    [
      gopls # language server
      delve # debugger
    ];

  programs.go.enable = true;
  # Add needed go directories
  systemd.user.tmpfiles.rules = [
    "d /home/${user}/go/src 0755 ${user} users"
    "d /home/${user}/go/bin 0755 ${user} users"
    "d /home/${user}/go/pkg 0755 ${user} users"
  ];
}
