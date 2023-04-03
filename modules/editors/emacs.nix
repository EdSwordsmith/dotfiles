{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.editors.emacs;
in
{
  options.edu.editors.emacs.enable = mkEnableOption "emacs";

  config = mkIf cfg.enable {
    services.emacs = {
      enable = true;
      package = ((pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages
        (epkgs: [ epkgs.vterm ]));
    };

    environment.systemPackages = with pkgs; [
      # Doom Emacs dependencies
      git
      ripgrep
      coreutils
      fd
      clang

      # Module dependencies
      nodePackages.npm
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
    ];
  };
}
