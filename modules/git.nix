{ config, options, pkgs, lib, configDir, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.git;
in
{
  options.edu.git.enable = mkEnableOption "git";

  config = mkIf cfg.enable {
    hm.programs.git = {
      enable = true;
      userName = "Eduardo Espadeiro";
      userEmail = "eduardo.espadeiro@tecnico.ulisboa.pt";
      extraConfig = {
        color.ui = true;
        pull.rebase = true;
        init.defaultBranch = "main";
        url."git@github.com".pushinsteadOf = "https://github.com/";
        commit.template = "${configDir}/gitmessage.txt";
        commit.verbose = true;
      };

      # Enable signing if the gpg module is enabled
      signing = mkIf config.edu.gpg.enable {
        signByDefault = true;
        key = "0CF1C5EAF76639CE034D9A5E686B41F974804CC1";
      };
    };
  };
}
