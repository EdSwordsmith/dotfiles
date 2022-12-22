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

    # Gnome extensions
    gnomeExtensions.tiling-assistant
    gnomeExtensions.blur-my-shell
  ];

  hm.home.packages = with pkgs; [
    spotify
    brave
    discord
    jetbrains-mono
    thunderbird
  ];

  hm.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
