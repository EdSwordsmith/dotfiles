{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.editors.intellij;
in
{
  options.edu.editors.intellij.enable = mkEnableOption "intellij";

  config = mkIf cfg.enable {
    hm.home.packages = with pkgs; [
      jetbrains.idea-ultimate
    ];
  };
}