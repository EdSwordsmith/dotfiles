{ config, options, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    docker-compose
    htop
    ripgrep
    fd
    tmux
    zip
    unzip
  ];

  hm.home.packages = with pkgs; [
    spotify
    brave
    discord
    vscode
    jetbrains-mono
  ];

  programs.steam.enable = true;

  environment.variables = { EDITOR = "nvim"; };
}
