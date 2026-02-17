{inputs, ...}: {
  programs.command-not-found.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.registry.unstable.flake = inputs.nixpkgs-unstable;

  nix.nixPath = ["nixpkgs=/etc/channels/nixpkgs" "nixos-config=/etc/nixos/configuration.nix" "/nix/var/nix/profiles/per-user/root/channels"];
  environment.etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;
}
