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
    };

    hm.wayland.windowManager.sway = {
      enable = true;
      systemdIntegration = true;
      wrapperFeatures = {
        base = true;
        gtk = true;
      };

      config = {
        modifier = "Mod4";
        terminal = "foot";
        #menu = "j4-dmenu-desktop";
        menu = "${pkgs.wofi}/bin/wofi -S drun";

        bars = [{ command = "waybar"; }];

        input = {
          "type:keyboard" = {
            xkb_layout = "pt";
          };

          "type:touchpad" = {
            tap = "enabled";
            natural_scroll = "enabled";
          };
        };

        output."*" = { bg = "/home/eduardo/Imagens/fornost.jpg fill"; };
      };

      extraConfig = ''
        bindsym Print exec ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy screen 
      '';

      extraConfigEarly = ''
        for_window [app_id="^brave-(?!browser).*"] shortcuts_inhibitor disable
        exec_always ${pkgs.autotiling}/bin/autotiling
      '';
    };
  };
}
