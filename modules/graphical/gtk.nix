{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.edu.graphical.gtk;
in
{
  options.edu.graphical.gtk = {
    enable = mkEnableOption "Gtk";
  };

  config = mkIf cfg.enable {
    hm.gtk = {
      enable = true;

      theme = {
        package = pkgs.gnome-themes-extra;
        name = "Adwaita-dark";
      };
    };
  };

}
