{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.editors.neovim;
in
{
  options.edu.editors.neovim.enable = mkEnableOption "neovim";

  config = mkIf cfg.enable {
    hm.programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        vim-nix
      ];
    };
  };
}
