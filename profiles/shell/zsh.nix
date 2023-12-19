{
  pkgs,
  profiles,
  ...
}: {
  imports = with profiles.shell; [starship];

  environment.shells = with pkgs; [zsh];

  programs.zsh.enable = true;

  hm.programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    syntaxHighlighting = {
      enable = true;
      styles.cursor = "fg=#ffffff";
    };

    shellAliases = {
      cd = "z";
      open = "xdg-open";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["fzf"];
    };

    plugins = [
      {
        name = "dracula/zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.sh";
        src = pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "zsh-syntax-highlighting";
          rev = "09c89b657ad8a27ddfe1d6f2162e99e5cce0d5b3";
          sha256 = "sha256-JrSKx8qHGAF0DnSJiuKWvn6ItQHvWpJ5pKo4yNbrHno=";
        };
      }
    ];
  };
}
