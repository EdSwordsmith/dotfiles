{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pombobot = {
      url = "git+ssh://git@github.com/PombosMalvados/pombo_bot";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jmusicbot = {
      url = "https://github.com/jagrosh/MusicBot/releases/download/0.3.9/JMusicBot-0.3.9.jar";
      flake = false;
    };

    wallpapers = {
      url = "git+ssh://git@github.com/EdSwordsmith/wallpapers";
      flake = false;
    };
  };

  outputs = inputs @ {self, ...}: let
    inherit (inputs.nixpkgs) lib;
    inherit (lib) nixosSystem hasSuffix removeSuffix;
    inherit (lib.filesystem) listFilesRecursive;
    inherit (builtins) readDir listToAttrs attrNames filter map;
    inherit (lib.attrsets) mapAttrs' nameValuePair;

    system = "x86_64-linux";
    user = "eduardo";
    configDir = ./config;
    secretsDir = ./secrets;

    wallpapers = let
      extensions = [".jpg" ".jpeg" ".png"];
      isImage = name: builtins.any (ext: lib.hasSuffix ext name) extensions;
      removeExts = name: builtins.foldl' (file: ext: lib.removeSuffix ext file) name extensions;
      files = filter isImage (attrNames (readDir inputs.wallpapers));
    in
      listToAttrs (map (file: {
          name = removeExts file;
          value = "${inputs.wallpapers}/${file}";
        })
        files);

    mkModules = path: filter (hasSuffix ".nix") (listFilesRecursive path);

    mkProfiles = dir: let
      mkLevel = entry: type:
        if (lib.hasSuffix ".nix" entry && type == "regular")
        then (import "${dir}/${entry}")
        else if type == "directory"
        then mkProfiles "${dir}/${entry}"
        else {};

      doMagic = key: value:
        nameValuePair (lib.removeSuffix ".nix" key)
        (mkLevel key value);
    in
      mapAttrs' doMagic (builtins.readDir dir);

    mkOverlays = path:
      map (m: import m {inherit inputs lib;}) (mkModules path);

    mkPkgs = path: pkgs:
      mapAttrs'
      (name: value:
        nameValuePair (lib.removeSuffix ".nix" name) (
          if value == "directory"
          then pkgs.callPackage "${path}/${name}/default.nix" {}
          else pkgs.callPackage "${path}/${name}" {}
        ))
      (readDir path);

    mkPkgsOverlay = path: final: prev: {
      edu = mkPkgs path prev;
    };

    pkgs = let
      args = {
        inherit system;
        config.allowUnfree = true;
      };
    in
      import inputs.nixpkgs (args
        // {
          overlays = [
            inputs.agenix.overlays.default
            (final: prev: {unstable = import inputs.nixpkgs-unstable args;})
            (mkPkgsOverlay ./pkgs)
          ];
        });

    # Imports every host defined in a directory.
    mkHosts = dir:
      listToAttrs (map
        (name: {
          inherit name;
          value = nixosSystem {
            inherit system pkgs;

            specialArgs = {
              inherit user inputs configDir secretsDir;
              profiles = mkProfiles ./profiles;
              wallpaper = wallpapers."${name}";
            };

            modules =
              [
                {networking.hostName = name;}

                inputs.home.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                  };
                }

                inputs.agenix.nixosModules.default
              ]
              ++ mkModules ./modules
              ++ mkModules "${dir}/${name}";
          };
        })
        (attrNames (readDir dir)));
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        packages = mkPkgs ./pkgs pkgs;
      };

      flake = {
        nixosConfigurations = mkHosts ./hosts;
      };
    };
}
