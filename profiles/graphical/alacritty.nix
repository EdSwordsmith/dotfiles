{
  config,
  lib,
  pkgs,
  ...
}: {
  hm.programs.alacritty = {
    enable = true;
    settings = {
      env = {"TERM" = "xterm-256color";};

      window = {
        opacity = 0.97;
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
          background = "0x191E24";
          foreground = "0xCBCCC6";
        };

        # Normal colors
        normal = {
          black = "0x191E2A";
          red = "0xFF3333";
          green = "0xBAE67E";
          yellow = "0xFFA759";
          blue = "0x73D0FF";
          magenta = "0xFFD580";
          cyan = "0x95E6CB";
          white = "0xC7C7C7";
        };

        # bright colors
        bright = {
          black = "0x686868";
          red = "0xF27983";
          green = "0xA6CC70";
          yellow = "0xFFCC66";
          blue = "0x5CCFE6";
          magenta = "0xFFEE99";
          cyan = "0x95E6CB";
          white = "0xFFFFFF";
        };
      };
    };
  };
}
