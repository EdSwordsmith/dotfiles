{pkgs, ...}: {
  hm.gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };
  };

  hm.qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
      }
    ];
  };
}
