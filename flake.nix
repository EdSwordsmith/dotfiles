{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home = {
      url = "github:nix-community/home-manager/release-22.11";
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
      inherit (inputs.nixpkgs.lib) nixosSystem hasSuffix;
      inherit (inputs.nixpkgs.lib.filesystem) listFilesRecursive;
      inherit (builtins) readDir listToAttrs attrNames filter;

      system = "x86_64-linux";
      user = "eduardo";
      configDir = ./config;
      secretsDir = ./secrets;

      pkgs = let args = { inherit system; config.allowUnfree = true; }; in
        import inputs.nixpkgs (args // {
          overlays = [
            inputs.agenix.overlay
            (final: prev: {
              unstable = import inputs.nixpkgs-unstable args;
            })
          ];
        });

      mkModules = path: filter (hasSuffix ".nix") (listFilesRecursive path);

      # Imports every host defined in a directory.
      mkHosts = dir: listToAttrs (map
        (name: {
          inherit name;
          value = nixosSystem {
            inherit system pkgs;
            specialArgs = { inherit user inputs configDir secretsDir; };
            modules = [
              { networking.hostName = name; }
              (dir + "/${name}/hardware.nix")
              (dir + "/${name}/configuration.nix")

              inputs.home.nixosModules.home-manager
              {
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
