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
    unstable.webcord
    mattermost-desktop
    slack
    evince
    unstable.thunderbird
    keepassxc
    pavucontrol
    gimp
    libreoffice
  ];

  hm.programs.mpv.enable = true;

  services.flatpak.enable = true;
}
