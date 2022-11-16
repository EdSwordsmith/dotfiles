{ config, options, pkgs, lib, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    firefox
    discord
    vscode
    emacs28NativeComp
    jetbrains.idea-ultimate
    jetbrains-mono
  ];

  hm.programs.exa = {
    enable = true;
    enableAliases = true;
  };

  hm.programs.bat.enable = true;

  programs.steam.enable = true;

  environment.variables = { EDITOR = "nvim"; };
}