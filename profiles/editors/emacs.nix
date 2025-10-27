{
  pkgs,
  profiles,
  ...
}: {
  imports = with profiles; [dev.common];

  services.emacs = {
    enable = true;
    defaultEditor = true;
    package =
      (pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages
      (epkgs: with epkgs; [vterm org-roam]);
  };

  environment.systemPackages = with pkgs; [
    # Doom Emacs dependencies
    git
    ripgrep
    coreutils
    fd
    clang

    # Module dependencies
    editorconfig-core-c
    sqlite # org-roam
    pandoc
    graphviz
  ];
}
