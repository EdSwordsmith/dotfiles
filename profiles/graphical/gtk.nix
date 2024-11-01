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
}
