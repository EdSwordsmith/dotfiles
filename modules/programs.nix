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

    
    # Gnome apps & extensions
    gnome.gnome-tweaks
    gnomeExtensions.tiling-assistant
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
  ];

  fonts = {
    enableDefaultFonts = true;
    
    fonts = with pkgs; [
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  hm.home.packages = with pkgs; [
    spotify
    brave
    discord
    thunderbird
  ];

  hm.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
