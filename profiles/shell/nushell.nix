{ config, options, pkgs, lib, user, profiles, ... }:

{
  imports = with profiles.shell; [ starship ];

  environment.shells = with pkgs; [ nushell ];

  hm.programs.nushell = {
    enable = true;
    shellAliases = {
      rebuild =
        "sudo nixos-rebuild switch --flake '/home/${user}/.config/nix#${config.networking.hostName}'";
      cd = "z";
    };
  };
}
