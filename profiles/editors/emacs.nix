{ config, options, pkgs, lib, ... }: {
  services.emacs = {
    enable = true;
    package = ((pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages
      (epkgs: [ epkgs.vterm epkgs.org-roam ]));
  };

  environment.systemPackages = with pkgs; [
    # Doom Emacs dependencies
    git
    ripgrep
    coreutils
    fd
    clang

    # Module dependencies
    nodejs
    editorconfig-core-c
    shfmt
    shellcheck
    pyright
    rnix-lsp
    sumneko-lua-language-server
    rust-analyzer
    clang-tools_15
    nixfmt
    nodePackages.typescript-language-server
    isort
    black
    sqlite # org-roam
    pandoc
    graphviz
    texlive.combined.scheme-full
  ];
}
