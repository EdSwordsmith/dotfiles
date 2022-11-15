{ config, options, pkgs, lib, user, ... }:

with lib;
{
    options.hm = mkOption { type = types.attrs; };

    config = {
      home-manager.users.${user} = mkAliasDefinitions options.hm;

      # Home Manager needs a bit of information about you and the
      # paths it should manage.
      hm.home.username = user;
      hm.home.homeDirectory = "/home/${user}";

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      hm.home.stateVersion = "22.05";

      # Let Home Manager install and manage itself.
      hm.programs.home-manager.enable = true;
    };
}
