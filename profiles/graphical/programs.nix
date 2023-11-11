{pkgs, ...}: {
  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      symbola
      font-awesome
      material-design-icons
      roboto
      jetbrains-mono
      fira-code
      fira
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      edu.ohxproto
      unstable.commit-mono
    ];
  };

  hm.home.packages = with pkgs; [
    spotify
    brave
    (webcord.override {
      electron_24 = pkgs.unstable.electron_27;
    })
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
