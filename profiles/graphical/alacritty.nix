{pkgs, ...}: let
  theme = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "alacritty";
    rev = "18353e319fada1e33c20b3dae840f9ce6eeede5d";
    sha256 = "sha256-VwP5iTQf3nFe2ZPVoc5adzoIMVYxfdHBdjVOfi6e5yA=";
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

    settings.import = ["${theme}/dracula.yml"];
  };
}
