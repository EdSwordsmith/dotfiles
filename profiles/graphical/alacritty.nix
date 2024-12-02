{configDir, ...}: {
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

    settings.general.import = ["${configDir}/gruber_darker.toml"];
  };
}
