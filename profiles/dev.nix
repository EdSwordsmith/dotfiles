{pkgs, ...}: let
  pythonPackages = p:
    with p; [
      numpy
      requests
      jupyter
      ipython
      flake8
    ];
in {
  hm.home.packages = with pkgs; [
    (python3.withPackages pythonPackages)
    racket
    (sbcl.withPackages (p: [p.agnostic-lizard]))
    unstable.julia-bin
    unstable.odin
    unstable.ols
  ];
}
