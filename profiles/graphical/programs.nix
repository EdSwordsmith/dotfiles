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
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      unstable._0xproto
      unstable.commit-mono
    ];
  };

  hm.home.packages = with pkgs; [
    spotify
    brave
    firefox
    armcord
    mattermost-desktop
    slack
    evince
    thunderbird
    keepassxc
    pavucontrol
    gimp
    libreoffice
  ];

  hm.services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  hm.programs.mpv.enable = true;

  services.flatpak.enable = true;
}
