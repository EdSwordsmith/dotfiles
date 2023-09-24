{ config, lib, pkgs, ... }:

{
  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      symbola
      font-awesome
      material-design-icons
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
    evince
    unstable.thunderbird
    keepassxc
    pavucontrol
    gimp
    unstable.zoom-us
  ];

  hm.programs.mpv.enable = true;

  services.flatpak.enable = true;

  hm.xdg.desktopEntries = {
    discord-pwa = {
      name = "Discord PWA";
      icon = "discord";
      exec = ''
        ${pkgs.brave}/bin/brave --new-window --app="https://discord.com/app"'';
      terminal = false;
      categories = [ "Application" ];
    };

    zoom = {
      name = "ZOOM";
      exec =
        ''${pkgs.brave}/bin/brave --new-window --app="https://pwa.zoom.us/wc"'';
      terminal = false;
      categories = [ "Application" ];
    };
  };
}
