{ lib, ... }:
final: prev: rec {
  edu.tokyo-night-nvim = final.callPackage ../packages/tokyonightnvim.nix { };
}
