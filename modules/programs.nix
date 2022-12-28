{ config, options, pkgs, lib, configDir, ... }:

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
    blackbox-terminal

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

  hm.xdg.desktopEntries = {
    discord-pwa = {
      name = "Discord PWA";
      icon = "discord";
      exec = "${pkgs.brave}/bin/brave --new-window --app=\"https://discord.com/app\"";
      terminal = false;
      categories = [ "Application" ];
    };
  };

  hm.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    gnome.epiphany
  ];
}
