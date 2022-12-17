{ config, options, pkgs, lib, inputs, secretsDir, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.services.pombobot;
  inherit (inputs.pombobot.packages.${pkgs.system}) pombobot;
  botDir = "/etc/pombobot";
in
{
  options.edu.services.pombobot.enable = mkEnableOption "Pombo Bot";

  config = mkIf cfg.enable {
    age.secrets.pombobot.file = "${secretsDir}/pombobot.age";
    age.secrets.pombobot.path = "${botDir}/.env";

    systemd.services.pombobot = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = "${pombobot}/bin/pombo_bot";
        WorkingDirectory = botDir;
      };
    };
  };
}
