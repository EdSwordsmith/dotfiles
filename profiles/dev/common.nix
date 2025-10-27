{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    # C/C++
    clang
    clang-tools
    cmake-language-server
    # Go
    go
    gopls
    # JS/TS
    nodejs
    nodePackages.typescript-language-server
    nodePackages."@astrojs/language-server"
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
    # Rust
    unstable.rust-analyzer
    unstable.rustc
    unstable.cargo
    # Shell
    shfmt
    shellcheck
    # Zig
    zls
    # Flutter
    flutter
  ];
}
