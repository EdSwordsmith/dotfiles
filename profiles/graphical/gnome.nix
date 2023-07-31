{ config, lib, pkgs, profiles, ... }:

{
  imports = with profiles.graphical; [ common ];

  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.tiling-assistant
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
  ];

  hm.home.packages = with pkgs; [ blackbox-terminal ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    gnome.epiphany
  ];
}
