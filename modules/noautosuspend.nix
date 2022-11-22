{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.noautosuspend;
in
{
  options.edu.noautosuspend.enable = mkEnableOption "noautosuspend";

  config = mkIf cfg.enable {
    # Disable auto suspend
    systemd.targets.sleep.enable = false;
    systemd.targets.suspend.enable = false;
    systemd.targets.hibernate.enable = false;
    systemd.targets.hybrid-sleep.enable = false;
  };
}
