{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.neovim;
in
{
  options.edu.neovim.enable = mkEnableOption "neovim";

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
