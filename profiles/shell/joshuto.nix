{ config, options, pkgs, lib, ... }:
{
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
}
