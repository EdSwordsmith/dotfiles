{ config, lib, pkgs, ... }:

{
  hm.home.packages = with pkgs; [ prismlauncher superTux ];

  programs.steam.enable = true;
}
