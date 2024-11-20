{
  pkgs,
  wallpaper,
  ...
}: {
  programs.hyprlock.enable = true;
  hm.programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        path = "${wallpaper}";

        blur_passes = 2;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = false;
      };

      input-field = {
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(100, 114, 125, 0.4)";
        font_color = "rgb(200, 200, 200)";
        fade_on_empty = false;
        font_family = "JetBrainsMono Nerd Font Bold";
        placeholder_text = ''<i><span foreground="##ffffff99">Enter Password</span></i>'';
        hide_input = false;
        position = "0, -225";
        halign = "center";
        valign = "center";
      };

      label = [
        # Time
        {
          text = ''cmd[update:1000] echo "<span>$(date +"%H:%M")</span>"'';
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 130;
          font_family = "JetBrainsMono Nerd Font Bold";
          position = "0, 240";
          halign = "center";
          valign = "center";
        }

        # Day-Month-Date
        {
          text = ''cmd[update:1000] echo -e "$(date +"%A, %d %B")"'';
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 30;
          font_family = "JetBrainsMono Nerd Font Bold";
          position = "0, 105";
          halign = "center";
          valign = "center";
        }

        # User
        {
          text = "Hi, $DESC";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 25;
          font_family = "JetBrainsMono Nerd Font Bold";
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];

      image = {
        path = "/home/eduardo/.face";
        border_color = "0xffdddddd";
        border_size = 0;
        size = 120;
        rounding = -1;
        rotate = 0;
        reload_time = -1;
        position = "0, -20";
        halign = "center";
        valign = "center";
      };
    };
  };
}
