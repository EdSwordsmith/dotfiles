{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.edu.graphical;
in
{
  options.edu.graphical = {
    enable = mkEnableOption "graphical";
  };

  config = mkIf cfg.enable {
    edu.graphical = {
      gtk.enable = true;
      sound.enable = true;
      programs.enable = true;
    };

    xdg.portal.enable = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
