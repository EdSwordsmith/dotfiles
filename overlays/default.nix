{ lib, ... }:
final: prev: rec {
  edu = {
    tokyo-night-nvim = final.callPackage ../packages/tokyonightnvim.nix { };
    activate-controller = final.callPackage ../packages/controller.nix { };
  };
}
