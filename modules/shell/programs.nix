{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    fzf
    wget
    docker-compose
    htop
    ripgrep
    fd
    tmux
    zip
    unzip
    agenix
    tldr
    man-pages
    man-pages-posix
    alejandra
    libqalculate
    gnumake
    rlwrap
  ];

  programs.nix-ld.enable = true;

  hm.programs.bat.enable = true;
  hm.programs.zoxide.enable = true;
  hm.programs.eza.enable = true;

  hm.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  documentation.dev.enable = true;
}
