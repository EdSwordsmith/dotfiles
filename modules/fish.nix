{ config, options, pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.fish;
in
{
  options.modules.fish.enable = mkEnableOption "fish";

  config = mkIf cfg.enable {
    hm.programs.zoxide.enable = true;

    hm.programs.fish = {
      enable = true;
      shellAbbrs = {
        rebuild = "sudo nixos-rebuild switch --flake '/home/eduardo/.config/nix#minastirith'";
        pfetch = "nix run nixpkgs#pfetch";
        cd = "z";
      };
    };

    hm.programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        format = "$username[@](bold green)$hostname$directory$all";

        username = {
          show_always = true;
          format = "[\\[](bold bright-red)[$user]($style)";
        };

        hostname = {
          ssh_only = false;
          format =  "[$hostname]($style) ";
          style = "bold blue";
        };

        directory = {
          format = "[$path]($style)[$read_only]($read_only_style)[\\]](bold bright-red) ";
        };
      };
    };
  };
}
