{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pombobot = {
      url = "git+ssh://git@github.com/PombosMalvados/pombo_bot";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jmusicbot = {
      url = "https://github.com/jagrosh/MusicBot/releases/download/0.3.8/JMusicBot-0.3.8.jar";
      flake = false;
    };
  };

  outputs = inputs @ { self, ... }:
    let
      inherit (inputs.nixpkgs.lib) nixosSystem mapAttrs hasSuffix;
      inherit (inputs.djtobis.nixosModules) djtobis;
      inherit (builtins) concatLists attrValues readDir listToAttrs attrNames;

      system = "x86_64-linux";
      user = "eduardo";
      configDir = "/home/eduardo/.config/nix/config";

      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [ inputs.agenix.overlay ];
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

        # Imports every host defined in a directory.
        mkHosts = dir: listToAttrs (map
          (name: {
            inherit name;
            value = inputs.nixpkgs.lib.nixosSystem {
              inherit system pkgs;
              specialArgs = { inherit user inputs configDir; };
              modules = [
                { networking.hostName = name; }
                (dir + "/${name}/hardware.nix")
                (dir + "/${name}/configuration.nix")

                inputs.home.nixosModules.home-manager {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                  };
                }

                inputs.agenix.nixosModule
              ] ++ mkModules ./modules;
            };
          })
          (attrNames (readDir dir)));
    in
    {
      nixosConfigurations = mkHosts ./hosts;
    };
}
