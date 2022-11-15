{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.neovim;
in
{
  options.modules.neovim.enable = mkEnableOption "neovim";

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