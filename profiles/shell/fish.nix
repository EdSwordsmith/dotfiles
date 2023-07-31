{ config, options, pkgs, lib, user, ... }:

{
  hm.programs.zoxide.enable = true;
  environment.shells = with pkgs; [ fish ];
  usr.shell = pkgs.fish;

  programs.fish.enable = true;

  hm.programs.fish = {
    enable = true;
    shellAbbrs = {
      rebuild =
        "sudo nixos-rebuild switch --flake '/home/${user}/.config/nix#${config.networking.hostName}'";
      cd = "z";
    };

    plugins = [{
      name = "fzf.fish";
      src = pkgs.fishPlugins.fzf-fish.src;
    }];
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
        format = "[$hostname]($style) ";
        style = "bold blue";
      };

      directory = {
        format =
          "[$path]($style)[$read_only]($read_only_style)[\\]](bold bright-red) ";
      };
    };
  };

  hm.programs.exa = {
    enable = true;
    enableAliases = true;
  };

  hm.programs.bat.enable = true;
}
