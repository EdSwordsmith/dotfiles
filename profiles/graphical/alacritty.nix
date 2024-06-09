{pkgs, ...}: let
  themes = pkgs.fetchFromGitHub {
    owner = "alacritty";
    repo = "alacritty-theme";
    rev = "94e1dc0b9511969a426208fbba24bd7448493785";
    sha256 = "sha256-bPup3AKFGVuUC8CzVhWJPKphHdx0GAc62GxWsUWQ7Xk=";
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
        size = 16.0;
        normal.family = "Iosevka Nerd Font Mono";
        bold.family = "Iosevka Nerd Font Mono";
        italic.family = "Iosevka Nerd Font Mono";
      };
    };

    settings.import = ["${themes}/themes/horizon-dark.toml"];
  };
}
