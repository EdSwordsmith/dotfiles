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

      # Let Home Manager install and manage itself.
      hm.programs.home-manager.enable = true;
    };
}
