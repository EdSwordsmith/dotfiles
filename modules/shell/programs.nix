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
    man-pages
    man-pages-posix
  ];

  hm.programs.bat.enable = true;
  hm.programs.zoxide.enable = true;

  hm.programs.exa = {
    enable = true;
    enableAliases = true;
  };

  hm.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  documentation.dev.enable = true;
}
