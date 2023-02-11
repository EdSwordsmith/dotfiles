{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.sway;
in
{
  options.edu.sway.enable = mkEnableOption "sway";

  config = mkIf cfg.enable {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        swaybg
        swaylock
        swayidle
        foot

        wl-clipboard
        sway-contrib.grimshot
        # bemenu
        # j4-dmenu-desktop
      ];
    };

    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;

    # Solves small cursor on HiDPI.
    hm.home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
      size = 24;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
    };

    hm.programs.waybar = {
      enable = true;
      systemd.enable = true;
      style = ./waybar.css;

      settings = [{
        height = 30;
        spacing = 6;

        modules-left = [
          "sway/workspaces"
          "sway/scratchpad"
        ];

        modules-center = [
          "sway/window"
        ];

        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "battery#bat2"
          "clock"
          "tray"
        ];

        "sway/workspaces".disable-scroll = true;
        
        "sway/scratchpad" = {
          format = "{icon} {count}";
          "show-empty" = false;
          "format-icons" = [
            ""
            "\uf2d2"
          ];
          tooltip = true;
          "tooltip-format" = "{app}: {title}";
        };

        tray.spacing = 10;
        
        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };

          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";

          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "battery#bat2" = {
          bat = "BAT2";
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };

          on-click = "pavucontrol";
          tooltip = false;
        };
      }];
    };

    hm.wayland.windowManager.sway = {
      enable = true;
      systemdIntegration = true;
      wrapperFeatures = {
        base = true;
        gtk = true;
      };

      config = rec {
        modifier = "Mod4";
        terminal = "foot";
        menu = "${terminal} --app-id=launcher -e ${pkgs.sway-launcher-desktop}/bin/sway-launcher-desktop";

        bars = [{ command = "waybar"; }];

        input = {
          "type:keyboard" = {
            xkb_layout = "pt";
          };

          "type:touchpad" = {
            tap = "enabled";
            click_method = "clickfinger";
            natural_scroll = "enabled";
          };
        };

        output."*" = { bg = "/home/eduardo/Imagens/fornost.jpg fill"; };
      };

      extraConfig = ''
        bindsym Print exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy screen 
      '';

      extraConfigEarly = ''
        for_window [app_id="^launcher$"] floating enable, sticky enable, resize set 30 ppt 60 ppt, border pixel 6
        for_window [app_id="^brave-(?!browser).*"] shortcuts_inhibitor disable
        exec_always ${pkgs.autotiling}/bin/autotiling
      '';
    };
  };
}
