{pkgs, ...}: let
  pythonPackages = p: with p; [numpy requests bitstring jupyter ipython flake8];
in {
  hm.home.packages = with pkgs; [
    (python3.withPackages pythonPackages)
    racket
    sbcl
    julia-bin
  ];
}
