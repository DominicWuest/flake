{
  description = "My NixOS config";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, nur }:
  let
    user = "dominic";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
			config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in
  {
    nixosConfigurations = {
      # Laptop
      onion = lib.nixosSystem {
        inherit system;

				# https://github.com/nix-community/home-manager/issues/2942
				pkgs = import nixpkgs {
					inherit system;
					config.allowUnfree = true;
				};

        modules = [
          ./configuration.nix
          ./hardware-configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = {
              imports = [ nur.hmModules.nur ./home.nix ];
            };
          }
        ];
      };
    };
  };
}
