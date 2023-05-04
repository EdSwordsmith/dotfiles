{ config, options, pkgs, lib, configDir, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    fzf
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
    tldr
  ];

  hm.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
