{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.edu.graphical.programs;
in
{
  options.edu.graphical.programs = {
    enable = mkEnableOption "graphical programs";
  };

  config = mkIf cfg.enable {
    fonts = {
      enableDefaultFonts = true;

      fonts = with pkgs; [
        font-awesome
        material-design-icons
        roboto
        jetbrains-mono
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];
    };

    hm.home.packages = with pkgs; [
      spotify
      brave
      discord
      mattermost-desktop
      slack
      thunderbird
      postman
      keepassxc
      pavucontrol
      gimp
    ];

    hm.xdg.desktopEntries = {
      discord-pwa = {
        name = "Discord PWA";
        icon = "discord";
        exec = "${pkgs.brave}/bin/brave --new-window --app=\"https://discord.com/app\"";
        terminal = false;
        categories = [ "Application" ];
      };

      zoom = {
        name = "ZOOM";
        exec = "${pkgs.brave}/bin/brave --new-window --app=\"https://pwa.zoom.us/wc\"";
        terminal = false;
        categories = [ "Application" ];
      };
    };
  };
}
