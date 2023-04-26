{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.shell.joshuto;
in
{
  options.edu.shell.joshuto.enable = mkEnableOption "joshuto";

  config = mkIf cfg.enable {
    hm.home.packages = with pkgs; [ joshuto ];

    hm.xdg.configFile."joshuto/joshuto.toml".source = ./joshuto.toml;

    hm.xdg.desktopEntries.joshuto = {
      name = "Joshuto";
      genericName = "File Manager";
      exec = "joshuto";
      terminal = true;
      categories = [ "ConsoleOnly" "System" "FileTools" "FileManager" ];
      mimeType = [ "inode/directory" ];
    };
  };
}
