{
  config,
  options,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.shell.gpg;
in {
  options.edu.shell.gpg.enable = mkEnableOption "gpg";

  config = mkIf cfg.enable {
    hm.services.gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };

    hm.programs.gpg.enable = true;
  };
}
