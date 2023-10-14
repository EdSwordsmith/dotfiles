{ config, options, pkgs, lib, user, profiles, ... }:

{
  imports = with profiles.shell; [ starship ];

  environment.shells = with pkgs; [ fish ];

  programs.fish.enable = true;

  hm.programs.fish = {
    enable = true;
    shellAbbrs = {
      rebuild = "sudo nixos-rebuild";
      cd = "z";
    };

    plugins = [{
      name = "fzf.fish";
      src = pkgs.fishPlugins.fzf-fish.src;
    }];
  };
}
