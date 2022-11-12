{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pombobot = {
      url = "/home/eduardo/dev/pombo_bot";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    djtobis = {
      url = "/home/eduardo/dev/flakes/djtobis";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, ... }:
    let
      inherit (inputs.nixpkgs.lib) nixosSystem mapAttrs hasSuffix;
      inherit (inputs.pombobot.nixosModules) pombobot;
      inherit (inputs.djtobis.nixosModules) djtobis;
      inherit (builtins) concatLists attrValues readDir;

      system = "x86_64-linux";
      user = "eduardo";

      pkgs = import inputs.nixpkgs {
        inherit system;
        #overlays = [ inputs.emacs-overlay.overlay ];
        config.allowUnfree = true;
      };

      # Imports every nix module from a directory, recursively.
      mkModules = dir: concatLists (attrValues (mapAttrs
        (name: value:
          if value == "directory"
          then mkModules "${dir}/${name}"
          else if value == "regular" && hasSuffix ".nix" name
          then [ (import "${dir}/${name}") ]
          else [])
        (readDir dir)));

      homeModules = mkModules ./modules/home;
    in
    {
      nixosConfigurations.minastirith = nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit user inputs; };
        modules = [
          pombobot
          djtobis

          (import ./configuration.nix)
          (import ./hardware-configuration.nix)

          inputs.home.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.eduardo = import ./home.nix;
              sharedModules = homeModules;
            };
          }
        ];
      };
    };
}
