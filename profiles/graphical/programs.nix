{
  pkgs,
  inputs,
  ...
}: {
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
    spotify
    firefox
    evince
    thunderbird
    keepassxc
    pavucontrol
    gimp
    onlyoffice-bin
    obs-studio
    discord
  ];

  hm.services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  hm.programs.mpv.enable = true;

  services.flatpak.enable = true;
}
