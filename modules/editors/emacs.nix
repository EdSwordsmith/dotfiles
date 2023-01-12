{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.editors.emacs;
in
{
  options.edu.editors.emacs.enable = mkEnableOption "emacs";

  config = mkIf cfg.enable {
    hm.programs.emacs = {
      enable = true;
      package = pkgs.emacs28NativeComp;
      extraPackages = epkgs: [
        epkgs.vterm
      ];
    };
  };
}
