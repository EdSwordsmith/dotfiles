{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, ... }:
    let
      inherit (inputs.home.nixosModules) home-manager;
      inherit (inputs.nixpkgs.lib) nixosSystem;

      system = "x86_64-linux";
      user = "eduardo";

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    in {
      nixosConfigurations.minastirith = nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit user; };
        modules = [
          (import ./configuration.nix)
          (import ./hardware-configuration.nix)

          home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.eduardo = import ./home.nix;
	  }
        ];
      };
    };
}
