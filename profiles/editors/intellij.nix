{
  config,
  options,
  pkgs,
  lib,
  ...
}: let
  intellij = with pkgs.unstable.jetbrains;
    plugins.addPlugins idea-ultimate ["164" "17718"];
  idea =
    pkgs.writeShellScriptBin "idea"
    "nohup ${intellij}/bin/idea-ultimate $@ >/dev/null 2>&1 &";
in {
  hm.home.packages = [intellij idea];
}
