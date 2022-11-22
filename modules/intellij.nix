{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.intellij;
in
{
  options.edu.intellij.enable = mkEnableOption "intellij";

  config = mkIf cfg.enable {
    hm.home.packages = with pkgs; [
      jetbrains.idea-ultimate
    ];
  };
}
