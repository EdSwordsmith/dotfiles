{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.edu.foot;
in
{
  options.edu.foot = {
    enable = mkEnableOption "foot";
  };

  config = mkIf cfg.enable {
    hm.programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "JetBrainsMono Nerd Font Mono:size=9";
        };
        cursor.color = "0A0E14 B3B1AD";

        colors = {
          background = "0A0E14";
          foreground = "B3B1AD";
          regular0 = "0A0E14";
          regular1 = "FF3333";
          regular2 = "C2D94C";
          regular3 = "FF8F40";
          regular4 = "59C2FF";
          regular5 = "FFEE99";
          regular6 = "95E6CB";
          regular7 = "B3B1AD";
          bright0 = "4D5566";
          bright1 = "FF3333";
          bright2 = "C2D94C";
          bright3 = "FF8F40";
          bright4 = "59C2FF";
          bright5 = "FFEE99";
          bright6 = "95E6CB";
          bright7 = "B3B1AD";
          alpha = 0.95;
        };
      };
    };
  };
}

