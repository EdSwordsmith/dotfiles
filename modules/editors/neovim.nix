{ config, options, pkgs, lib, ... }:
let

in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  hm.programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };
}
