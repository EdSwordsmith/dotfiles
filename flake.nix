{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pombobot.url = "/home/eduardo/dev/pombo_bot";
  };

  outputs = inputs @ { self, ... }:
    let
      inherit (inputs.home.nixosModules) home-manager;
      inherit (inputs.nixpkgs.lib) nixosSystem;
      inherit (inputs.nixosModules.pombobot) pomboBot;

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
          pomboBot

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
