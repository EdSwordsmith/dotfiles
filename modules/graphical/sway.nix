{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.graphical.sway;

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
  options.edu.graphical.sway.enable = mkEnableOption "sway";

  config = mkIf cfg.enable {
    edu.alacritty.enable = true;
    edu.graphical = {
      gtk.enable = true;
      sound.enable = true;
      waybar.enable = true;
    };

    hm.programs.mako.enable = true;

    programs.light.enable = true;
    usr.extraGroups = [ "video" ]; # For rootless light.

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        lockCommand

        swaybg
        swayidle
        wdisplays
        wl-clipboard
        sway-contrib.grimshot
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

    hm.wayland.windowManager.sway = {
      enable = true;
      systemdIntegration = true;
      wrapperFeatures = {
        base = true;
        gtk = true;
      };

      config = rec {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "TERMINAL_COMMAND=${terminal} ${terminal} --class launcher -e ${pkgs.sway-launcher-desktop}/bin/sway-launcher-desktop";
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

          "type:touch" = {
            drag = "enabled";
            drag_lock = "enabled";
            map_to_output = "eDP-1";
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
            "Print+a" =
              "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy area";
            "Shift+Print+a" =
              "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save area";
            "Print+w" =
              "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy window";
            "Shift+Print+w" =
              "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save window";

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
        day = 5700;
        night = 2700;
      };
    };
  };
}