{ config, options, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    docker-compose
    btop
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
    vscode
    jetbrains-mono
  ];

  programs.steam.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
