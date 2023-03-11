{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.edu.graphical.games;
in
{
  options.edu.graphical.games = {
    enable = mkEnableOption "games";
  };

  config = mkIf cfg.enable {
    hm.home.packages = [
      prismlauncher
      superTux
    ];

    programs.steam.enable = true;
  };
}
