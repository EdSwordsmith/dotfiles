{ config, options, pkgs, lib, user, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.edu.fish;
in
{
  options.edu.fish.enable = mkEnableOption "fish";

  config = mkIf cfg.enable {
    hm.programs.zoxide.enable = true;
    environment.shells = with pkgs; [ fish ];
    usr.shell = pkgs.fish;

    hm.programs.fish = {
      enable = true;
      shellAbbrs = {
        rebuild = "sudo nixos-rebuild switch --flake '/home/${user}/.config/nix#${config.networking.hostName}'";
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


    hm.programs.exa = {
      enable = true;
      enableAliases = true;
    };

    hm.programs.bat.enable = true;
  };
}
