{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "eduardo";
  home.homeDirectory = "/home/eduardo";
  
  home.packages = with pkgs; [
    spotify
    brave
    firefox
    discord
    vscode
    emacs28NativeComp
    jetbrains.idea-ultimate
    jetbrains-mono
  ];

  modules = {
    fish.enable = true;
    neovim.enable = true;
    gpg.enable = true;
    git.enable = true;
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.bat.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
