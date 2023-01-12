{ config, options, pkgs, lib, inputs, configDir, secretsDir, ... }:
let
  inherit (lib) mkEnableOption mkIf mkOption types;
  inherit (lib.attrsets) mapAttrs;
  cfg = config.edu.services.minecraft;
in
{
  options.edu.services.minecraft = {
    enable = mkEnableOption "Minecraft";
    servers = mkOption {
      type = with types; attrsOf (attrsOf (oneOf [ str package ]));
      default = [ ];
      example = {
        server1 = {
          memory = "2G";
          jre = pkgs.jre8;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services = mapAttrs
      (name: server: {
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
          ExecStart = "${server.jre or pkgs.jre}/bin/java -Xmx${server.memory} -Xms${server.memory} -jar server.jar nogui";
          WorkingDirectory = "/home/eduardo/minecraft/${name}";
        };
      })
      cfg.servers;
  };
}
