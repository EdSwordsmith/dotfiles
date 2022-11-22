{ config, options, pkgs, lib, inputs, configDir, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.djtobis;
  inherit (inputs) jmusicbot;
in
{
  options.edu.djtobis.enable = mkEnableOption "DJ Tóbis";

  config = mkIf cfg.enable {
    systemd.services.djtobis = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.jre8}/bin/java -Dnogui=true -jar ${jmusicbot}";
        WorkingDirectory = "${configDir}/djtobis";
      };
    };
  };
}
