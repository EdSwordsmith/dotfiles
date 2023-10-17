{
  pkgs,
  ...
}: {
  hm.programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ./waybar.css;

    settings = [
      {
        height = 30;
        spacing = 6;

        modules-left = ["sway/workspaces"];

        modules-center = ["sway/window"];

        modules-right = ["pulseaudio" "backlight" "network" "battery" "clock" "tray"];

        "sway/workspaces".disable-scroll = true;

        tray.spacing = 10;

        clock = {
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          format = "{:%Y-%m-%d %H:%M} 󱑒";
        };

        battery = {
          states = {
            warning = 25;
            critical = 15;
          };

          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂉";
          format-plugged = "{capacity}% 󰚥";
          format-alt = "{time} {icon}";

          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) 󰖩";
          format-ethernet = "{ipaddr}/{cidr} 󰈀";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        backlight = {
          format = "{percent}% {icon}";
          format-icons = ["󰃚" "󰃛" "󰃜" "󰃝" "󰃞" "󰃟" "󰃠"];
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-muted = "󰖁";
          format-icons = {default = ["󰕿" "󰖀" "󰕾"];};
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          tooltip = false;
        };
      }
    ];
  };
}
