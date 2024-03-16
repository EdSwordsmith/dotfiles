{
  config,
  options,
  lib,
  configDir,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.shell.git;
  signers = builtins.toFile "signers" ''
    eduardo.espadeiro@tecnico.ulisboa.pt,eduardo.espadeiro@rnl.tecnico.ulisboa.pt ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAKa+VAFnzoQdVvK1LUJYQi3jVFhU9m0ziNuGdOs4dhN eduardo@fornost
  '';
in {
  options.edu.shell.git = {
    enable = mkEnableOption "git";
    signing = mkEnableOption "signing";
  };

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

        gpg.ssh.allowedSignersFile = signers;
        gpg.format = "ssh";
      };

      signing = mkIf cfg.signing {
        signByDefault = true;
        key = "~/.ssh/id_ed25519.signing";
      };
    };
  };
}
