{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.edu.graphical.gnome;
in
{
  options.edu.graphical.gnome = {
    enable = mkEnableOption "gnome";
  };

  config = mkIf cfg.enable {
    edu.graphical.enable = true;

    services.xserver.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
      gnomeExtensions.tiling-assistant
      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash-to-dock
    ];

    hm.home.packages = with pkgs; [
      blackbox-terminal
    ];

    environment.gnome.excludePackages = with pkgs; [
      gnome-console
      gnome.epiphany
    ];
  };
}
