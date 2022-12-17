{ lib, config, pkgs, inputs, ... }:

{
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  nix.nixPath = [ "nixpkgs=/etc/channels/nixpkgs" "nixos-config=/etc/nixos/configuration.nix" "/nix/var/nix/profiles/per-user/root/channels" ];
  environment.etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;
}
