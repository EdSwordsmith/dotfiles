{pkgs, ...}: let
  theme = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "alacritty";
    rev = "9ae0fdedd423803f0401f6e7a23cd2bb88c175b2";
    sha256 = "sha256-MgRH5Lc8wyZ6AQZweyL1QzO5eBzVdjbOPQeRs/Mf51M=";
  };
in {
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
    };

    settings.import = ["${theme}/dracula.toml"];
  };
}
