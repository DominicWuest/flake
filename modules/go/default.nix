{ pkgs, user, ... }:

let
  pkgsite = with pkgs; buildGoModule
    {
      name = "pkgsite";
      src = fetchFromGitHub {
        owner = "golang";
        repo = "pkgsite";
        rev = "8e5e504098ab1a2d307a1300a817660a892604b1";
        sha256 = "sha256-UVYfEjwhqVEdFsI2hcxHa901c6Kf682FzNxBLWa1WZU=";
      };
      vendorHash = "sha256-HWeKFPqPeIF6hivuTHneZ7O5J/t1qa9yWGunhGqE4/k=";
      checkPhase = ''
        export GOWORK=off
      '';
    };
in
{
  home.packages = with pkgs;
    [
      gopls # language server
      delve # debugger
      golint # linter
      go-tools # static checker
      gotools # More devloping tools

      # Third party dev tools
      cobra-cli
      pkgsite
    ];

  programs.go.enable = true;
  # Add needed go directories
  systemd.user.tmpfiles.rules = [
    "d /home/${user}/go/src 0755 ${user} users"
    "d /home/${user}/go/bin 0755 ${user} users"
    "d /home/${user}/go/pkg 0755 ${user} users"
  ];
}
