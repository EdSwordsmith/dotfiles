{pkgs, ...}: {
  services.emacs = {
    enable = true;
    defaultEditor = true;
    package =
      (pkgs.emacsPackagesFor pkgs.emacs29-pgtk).emacsWithPackages
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
    nodejs
    editorconfig-core-c
    shfmt
    shellcheck
    pyright
    sumneko-lua-language-server
    unstable.rust-analyzer
    clang-tools_15
    nodePackages.typescript-language-server
    nodePackages."@astrojs/language-server"
    isort
    black
    sqlite # org-roam
    pandoc
    graphviz
    texlive.combined.scheme-full
    texlab
    metals
    gopls
    ocamlformat
    ocamlPackages.ocaml-lsp
    ocamlPackages.merlin
    ocamlPackages.ocp-indent
    zls
    cmake-language-server
    elixir-ls
  ];
}
