{
  config,
  options,
  lib,
  configDir,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.shell.git;
in {
  options.edu.shell.git.enable = mkEnableOption "git";

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
        core.editor = "nvim";
      };

      # Enable signing if the gpg module is enabled
      signing = mkIf config.edu.shell.gpg.enable {
        signByDefault = true;
        key = "0CF1C5EAF76639CE034D9A5E686B41F974804CC1";
      };
    };
  };
}
