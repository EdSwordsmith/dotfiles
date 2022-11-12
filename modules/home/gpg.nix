{ config, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.gpg;
in
{
  options.modules.gpg.enable = mkEnableOption "gpg";

  config = mkIf cfg.enable {
    services.gpg-agent.enable = true;
    programs.gpg.enable = true;
  };
}