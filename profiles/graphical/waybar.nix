{
  pkgs,
  configDir,
  ...
}: {
  hm.programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = configDir + "/waybar.css";

    settings = [
      {
        height = 30;
        spacing = 6;

        modules-left = ["hyprland/workspaces" "sway/workspaces"];

        modules-center = ["hyprland/window" "sway/window"];

        modules-right = ["pulseaudio" "backlight" "network" "battery" "clock" "tray" "custom/notifs"];

        "sway/workspaces".disable-scroll = true;

        tray.spacing = 10;

        clock = {
          locale = "C";
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

        "custom/notifs" = {
          tooltip = false;
          format = "{} {icon}";
          "format-icons" = {
            notification = "󱅫";
            none = "";
            "dnd-notification" = " ";
            "dnd-none" = "󰂛";
            "inhibited-notification" = " ";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = " ";
            "dnd-inhibited-none" = " ";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          exec = "swaync-client -swb";
          "on-click" = "sleep 0.1 && swaync-client -t -sw";
          "on-click-right" = "sleep 0.1 && swaync-client -d -sw";
          escape = true;
        };
      }
    ];
  };
}
