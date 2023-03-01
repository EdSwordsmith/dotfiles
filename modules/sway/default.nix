{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.sway;

  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };


  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      '';
  };

  lockCommand = pkgs.writeShellScriptBin "swaylock" ''
    ${pkgs.swaylock-effects}/bin/swaylock -f \
      --screenshots \
      --clock \
      --indicator \
      --indicator-radius 100 \
      --indicator-thickness 7 \
      --effect-blur 7x5 \
      --effect-vignette 0.5:0.5 \
      --ring-color bb00cc \
      --key-hl-color 880033 \
      --line-color 00000000 \
      --inside-color 00000088 \
      --separator-color 00000000 \
      --grace 2 \
      --fade-in 0.2
  '';
in
{
  options.edu.sway.enable = mkEnableOption "sway";

  config = mkIf cfg.enable {
    edu.foot.enable = true;

    hm.programs.mako.enable = true;

    programs.light.enable = true;
    usr.extraGroups = [ "video" ]; # For rootless light.

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        dbus-sway-environment
        configure-gtk
        lockCommand

        swaybg
        swayidle
        foot
        wdisplays
        wl-clipboard
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

    hm.programs.swaylock.settings = {
      color = "000000";
      show-failed-attempts = true;
      image = "/home/eduardo/Imagens/fornost.jpg";
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
        ];

        modules-center = [
          "sway/window"
        ];

        modules-right = [
          "pulseaudio"
          "backlight"
          "network"
          "battery"
          "battery#bat2"
          "clock"
          "tray"
        ];

        "sway/workspaces".disable-scroll = true;

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

        backlight = {
          format = "{percent}% {icon}";
          format-icons = [ "" "" ];
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
        menu = "TERMINAL_COMMAND=${terminal} ${terminal} --app-id=launcher -e ${pkgs.sway-launcher-desktop}/bin/sway-launcher-desktop";

        bars = [ ];

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

        keybindings =
          let
            modifier =
              config.hm.wayland.windowManager.sway.config.modifier;
          in
          lib.mkOptionDefault {
            "${modifier}+Escape" = "exec swaylock";

            # Screenshots
            "Print" =
              "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy area";
            "Shift+Print" =
              "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save area";

            # Brightness
            "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -T 0.72";
            "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -T 1.4";

            # Volume
            "XF86AudioRaiseVolume" =
              "exec '${pkgs.pamixer}/bin/pamixer --increase 5'";
            "XF86AudioLowerVolume" =
              "exec '${pkgs.pamixer}/bin/pamixer --decrease 5'";
            "XF86AudioMute" = "exec '${pkgs.pamixer}/bin/pamixer -t'";
            "XF86AudioMicMute" =
              "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";
          };

        # TODO: Wallpaper variable
        output."*" = { bg = "/home/eduardo/Imagens/fornost.jpg fill"; };
      };

      extraConfigEarly = ''
        for_window [app_id="^launcher$"] floating enable, sticky enable, resize set 30 ppt 60 ppt, border pixel 6
        for_window [app_id="^brave-(?!browser).*"] shortcuts_inhibitor disable
        exec_always ${pkgs.autotiling}/bin/autotiling
      '';

      extraConfig = ''
        exec dbus-sway-environment
        exec configure-gtk
      '';
    };

    hm.services.swayidle = {
      enable = true;
      events = [
        { event = "before-sleep"; command = "${lockCommand}/bin/swaylock"; }
        { event = "lock"; command = "${lockCommand}/bin/swaylock"; }
      ];
      timeouts = [
        { timeout = 300; command = "${lockCommand}/bin/swaylock"; }
        {
          timeout = 60;
          command = ''
            if ${pkgs.procps}/bin/pgrep swaylock; then ${pkgs.sway}/bin/swaymsg "output * dpms off"; fi'';
          resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * dpms on"'';
        }
      ];
    };

    hm.services.gammastep = {
      enable = true;
      provider = "manual";
      latitude = 38.7;
      longitude = -9.14;
      temperature = {
        day = 6500;
        night = 2000;
      };
    };
  };
}
