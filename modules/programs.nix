{ config, options, pkgs, lib, configDir, ... }:

{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
    blackbox-terminal
    postman
    keepassxc
    pavucontrol

    # Gnome apps & extensions
    gnome.gnome-tweaks
    gnomeExtensions.tiling-assistant
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
  ];

  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      font-awesome
      roboto
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  hm.home.packages = with pkgs; [
    spotify
    brave
    discord
    mattermost-desktop
    slack
    thunderbird
    prismlauncher
    superTux
  ];

  hm.xdg.desktopEntries = {
    discord-pwa = {
      name = "Discord PWA";
      icon = "discord";
      exec = "${pkgs.brave}/bin/brave --new-window --app=\"https://discord.com/app\"";
      terminal = false;
      categories = [ "Application" ];
    };

    zoom = {
      name = "ZOOM";
      exec = "${pkgs.brave}/bin/brave --new-window --app=\"https://pwa.zoom.us/wc\"";
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
