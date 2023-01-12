{ config, options, pkgs, lib, inputs, configDir, secretsDir, ... }:
let
  inherit (lib) mkEnableOption mkIf mkOption types;
  inherit (builtins) listToAttrs;
  cfg = config.edu.services.minecraft;
in
{
  options.edu.services.minecraft = {
    enable = mkEnableOption "Minecraft";
    servers = mkOption {
      type = with types; listOf (attrsOf (oneOf [ str package ]));
      default = [];
      example = [
        {
          name = "server1";
          dir = "/srv/minecraft/server1";
          memory = "2G";
          jre = pkgs.jre8;
        }
      ];
    };
  };

  config = mkIf cfg.enable {
    systemd.services = listToAttrs (map
      (server: {
        name = "minecraft-${server.name}";
        value = {
          wantedBy = [ "multi-user.target" ];
          after = [ "network.target" ];
          serviceConfig = {
            ExecStart = "${server.jre or pkgs.jre8}/bin/java -Xmx${server.memory} -Xms${server.memory} -jar server.jar nogui";
            WorkingDirectory = "${server.dir}";
          };
        };
      })
      cfg.servers);
  };
}
