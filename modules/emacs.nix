{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.emacs;
in
{
  options.edu.emacs.enable = mkEnableOption "emacs";

  config = mkIf cfg.enable {
    hm.programs.emacs = {
      enable = true;
      package = pkgs.emacs28NativeComp;
      extraPackages = epkgs: [
        pkgs.emacsPackages.vterm
      ];
    };
  };
}
