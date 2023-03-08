{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.edu.alacritty;
in
{
  options.edu.alacritty = {
    enable = mkEnableOption "alacritty";
  };

  config = mkIf cfg.enable {
    hm.programs.alacritty = {
      enable = true;
      settings = {
        env = {
          "TERM" = "xterm-256color";
        };

        window = {
          opacity = 0.95;
          padding.x = 10;
          padding.y = 10;
          decorations = "None";
        };

        font = {
          size = 14.0;
          normal.family = "JetBrainsMono Nerd Font Mono";
          bold.family = "JetBrainsMono Nerd Font Mono";
          italic.family = "JetBrainsMono Nerd Font Mono";
        };

        colors = {
          # Default colors
          primary = {
            background = "0x0A0E14";
            foreground = "0xB3B1AD";
          };

          # Normal colors
          normal = {
            black = "0x0A0E14";
            red = "0xFF3333";
            green = "0xC2D94C";
            yellow = "0xFF8F40";
            blue = "0x59C2FF";
            magenta = "0xFFEE99";
            cyan = "0x95E6CB";
            white = "0xB3B1AD";
          };

          # bright colors
          bright = {
            black = "0x4D5566";
            red = "0xFF3333";
            green = "0xC2D94C";
            yellow = "0xFF8F40";
            blue = "0x59C2FF";
            magenta = "0xFFEE99";
            cyan = "0x95E6CB";
            white = "0xB3B1AD";
          };
        };
      };
    };
  };
}

