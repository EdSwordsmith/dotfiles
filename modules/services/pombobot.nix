{ config, options, pkgs, lib, inputs, configDir, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.services.pombobot;
  inherit (inputs.pombobot.packages.${pkgs.system}) pombobot;
in
{
  options.edu.services.pombobot.enable = mkEnableOption "Pombo Bot";

  config = mkIf cfg.enable {
    systemd.services.pombobot = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = "${pombobot}/bin/pombo_bot";
        WorkingDirectory = "${configDir}/pombobot";
      };
    };
  };
}
