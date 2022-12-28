{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.edu.gtk;
in
{
  options.edu.gtk = {
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
