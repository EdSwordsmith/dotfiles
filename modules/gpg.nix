{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.gpg;
in
{
  options.edu.gpg.enable = mkEnableOption "gpg";

  config = mkIf cfg.enable {
    hm.services.gpg-agent.enable = true;
    hm.programs.gpg.enable = true;
  };
}
