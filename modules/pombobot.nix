{ config, options, pkgs, lib, inputs, configDir, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.pombobot;
  inherit (inputs.pombobot.${pkgs.system}) pombobot;
in
{
  options.modules.pombobot.enable = mkEnableOption "Pombo Bot";

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