{
  config,
  options,
  lib,
  secretsDir,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.services.djtobis;
in {
  options.edu.services.djtobis.enable = mkEnableOption "DJ Tóbis";

  config = mkIf cfg.enable {
    users.users.djtobis = {
      home = "${config.services.jmusicbot.stateDir}";
      group = "djtobis";
      isSystemUser = true;
    };

    users.groups.djtobis.members = ["djtobis"];

    age.secrets.djtobis = {
      file = "${secretsDir}/djtobis.age";
      path = "${config.services.jmusicbot.stateDir}/config.txt";
      owner = "djtobis";
      group = "djtobis";
    };

    age.secrets."NUNO.mp4" = {
      file = "${secretsDir}/NUNO.mp4.age";
      path = "${config.services.jmusicbot.stateDir}/NUNO.mp4";
      owner = "djtobis";
      group = "djtobis";
    };

    services.jmusicbot.enable = true;
    systemd.services.jmusicbot.serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = "djtobis";
    };
  };
}
