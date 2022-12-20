{ config, options, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    docker-compose
    htop
    ripgrep
    fd
    tmux
    zip
    unzip
    agenix
    nixpkgs-fmt
  ];

  hm.home.packages = with pkgs; [
    spotify
    brave
    discord
    jetbrains-mono
  ];

}
