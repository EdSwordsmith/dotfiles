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
      (nerdfonts.override {fonts = ["JetBrainsMono" "Iosevka"];})
    ];
  };

  hm.home.packages = with pkgs; [
    spotify
    firefox
    evince
    okular
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
