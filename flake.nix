{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pombobot.url = "/home/eduardo/dev/pombo_bot";
    djtobis.url = "/home/eduardo/dev/flakes/djtobis";
  };

  outputs = inputs @ { self, ... }:
    let
      inherit (inputs.home.nixosModules) home-manager;
      inherit (inputs.nixpkgs.lib) nixosSystem;
      inherit (inputs.pombobot.nixosModules) pombobot;
      inherit (inputs.djtobis.nixosModules) djtobis;

      system = "x86_64-linux";
      user = "eduardo";

      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [ inputs.pombobot.overlay ];
        config.allowUnfree = true;
      };

    in
    {
      nixosConfigurations.minastirith = nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit user; };
        modules = [
          pombobot
          djtobis

          (import ./configuration.nix)
          (import ./hardware-configuration.nix)

          home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.eduardo = import ./home.nix;
          }
        ];
      };
    };
}
