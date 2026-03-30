{configDir, ...}: {
  hm.programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Eduardo Espadeiro";
        email = "eduardo.espadeiro@tecnico.ulisboa.pt";
      };

      color.ui = true;
      pull.rebase = true;
      init.defaultBranch = "main";
      url."git@github.com".pushinsteadOf = "https://github.com/";
      commit.template = "${configDir}/git/commit_message.txt";
      commit.verbose = true;
      core.editor = "nvim";
    };
  };
}
