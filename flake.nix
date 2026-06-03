{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    meadhal = {
      url = "git+ssh://git@github.com/PombosMalvados/meadhal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dunedain.url = "git+ssh://git@github.com/EdSwordsmith/dunedain";
  };

  outputs = inputs @ {...}: let
    inherit (inputs.nixpkgs) lib;
    inherit (lib) nixosSystem hasSuffix;
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
      wallpaperDir = "${inputs.dunedain}/wallpapers";
      files = filter isImage (attrNames (readDir wallpaperDir));
    in
      listToAttrs (map (file: {
          name = removeExts file;
          value = "${wallpaperDir}/${file}";
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

    mkPkgs = path: pkgs:
      mapAttrs'
      (name: value:
        nameValuePair (lib.removeSuffix ".nix" name) (
          if value == "directory"
          then pkgs.callPackage "${path}/${name}/default.nix" {}
          else pkgs.callPackage "${path}/${name}" {}
        ))
      (readDir path);

    mkPkgsOverlay = path: _final: prev: {
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
            (_final: _prev: {unstable = import inputs.nixpkgs-unstable args;})
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
              profiles = (mkProfiles ./profiles) // {private = inputs.dunedain.nixosModules;};
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
                inputs.flake-programs-sqlite.nixosModules.programs-sqlite
                inputs.meadhal.nixosModules.default
              ]
              ++ mkModules ./modules
              ++ mkModules "${dir}/${name}";
          };
        })
        (attrNames (readDir dir)));
  in {
    packages.${system} = mkPkgs ./pkgs pkgs;
    # https://github.com/NixOS/nix/pull/11438#issuecomment-2343378813
    formatter.${system} = pkgs.writeShellScriptBin "formatter" ''
      if [[ $# -eq 0 ]]; then
        prj_root=$(git rev-parse --show-toplevel 2>/dev/null || echo .)
        set -- "$prj_root"
      fi

      ${lib.getExe pkgs.deadnix} --hidden --edit "$@"
      ${lib.getExe pkgs.alejandra} "$@"
    '';
    nixosConfigurations = mkHosts ./hosts;
  };
}
