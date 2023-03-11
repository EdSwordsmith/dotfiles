{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.edu.graphical.sound;
in
{
  options.edu.graphical.sound = {
    enable = mkEnableOption "sound";
  };

  config = mkIf cfg.enable {
    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

}
