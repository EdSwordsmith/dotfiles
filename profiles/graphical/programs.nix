{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      symbola
      font-awesome
      material-design-icons
      roboto
      jetbrains-mono
      fira-code
      fira
      _0xproto
      iosevka
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
    ];
  };

  hm.home.packages = with pkgs; [
    firefox
    spotify
    evince
    keepassxc
    pavucontrol
    gimp
    pinta
    onlyoffice-desktopeditors
    obs-studio
    discord
  ];

  hm.programs.mpv.enable = true;

  services.flatpak.enable = true;
}
