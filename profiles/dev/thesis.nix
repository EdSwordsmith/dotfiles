{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    # Common Lisp
    (sbcl.withPackages (p: [p.agnostic-lizard]))
    # Julia
    julia-bin
    # LaTeX
    texlive.combined.scheme-full
    texlab
    # Racket
    racket
    # Scala
    metals
  ];
}
