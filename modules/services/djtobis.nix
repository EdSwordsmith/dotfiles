{ config, options, pkgs, lib, inputs, configDir, secretsDir, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.services.djtobis;
  inherit (inputs) jmusicbot;
  botDir = "/etc/djtobis";
in
{
  options.edu.services.djtobis.enable = mkEnableOption "DJ Tóbis";

  config = mkIf cfg.enable {
    age.secrets.djtobis.file = "${secretsDir}/djtobis.age"; 
    age.secrets.djtobis.path = "${botDir}/config.txt";
    age.secrets."NUNO.mp4".file = "${secretsDir}/NUNO.mp4.age"; 
    age.secrets."NUNO.mp4".path = "${botDir}/NUNO.mp4";

    environment.etc = {
      "djtobis/Playlists".source = "${configDir}/djtobis/Playlists";
    };

    systemd.services.djtobis = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.jre8}/bin/java -Dnogui=true -jar ${jmusicbot}";
        WorkingDirectory = botDir;
      };
    };
  };
}
