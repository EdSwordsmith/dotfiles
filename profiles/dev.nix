{ config, options, pkgs, lib, ... }:

let pythonPackages = p: with p; [ numpy requests ];
in {
  hm.home.packages = with pkgs; [
    (python3.withPackages pythonPackages)
    racket
    sbcl
    julia-bin
  ];
}
