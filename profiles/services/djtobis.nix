{
  pkgs,
  config,
  lib,
  secretsDir,
  ...
}: {
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

  services.jmusicbot = {
    enable = true;
    package = pkgs.unstable.jmusicbot;
  };

  systemd.services.jmusicbot.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "djtobis";
  };
}
