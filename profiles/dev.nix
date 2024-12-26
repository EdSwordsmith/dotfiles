{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    # C/C++
    clang
    clang-tools
    cmake-language-server
    # Common Lisp
    (sbcl.withPackages (p: [p.agnostic-lizard]))
    # Elixir
    elixir-ls
    # Go
    gopls
    # JS/TS
    nodejs
    nodePackages.typescript-language-server
    nodePackages."@astrojs/language-server"
    # Julia
    julia-bin
    # LaTeX
    texlive.combined.scheme-full
    texlab
    # OCaml
    ocamlformat
    ocamlPackages.ocaml-lsp
    ocamlPackages.merlin
    ocamlPackages.ocp-indent
    # Odin
    unstable.ols
    # Python
    (python3.withPackages (p: with p; [numpy requests jupyter ipython flake8]))
    pyright
    isort
    black
    # Racket
    racket
    # Rust
    unstable.rust-analyzer
    # Scala
    metals
    # Shell
    shfmt
    shellcheck
    # Zig
    zls
  ];
}
