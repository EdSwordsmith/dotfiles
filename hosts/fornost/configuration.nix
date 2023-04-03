{ config, pkgs, ... }:

{
  edu = {
    services.wgrnl = {
      enable = true;
      privateKeyFile = "/etc/wireguard/privkey";
    };

    graphical = {
      sway.enable = true;
      gnome.enable = true;
      games.enable = true;
    };

    editors = {
      emacs.enable = true;
      intellij.enable = true;
    };

    shell = {
      gpg.enable = true;
      fish.enable = true;
      git.enable = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  virtualisation.docker.enable = true;

  services.fprintd.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Configure keymap 
  console.keyMap = "pt-latin1";
  services.xserver = {
    layout = "pt";
    xkbVariant = "";
  };

  usr.extraGroups = [ "dialout" "docker" ];

  networking.firewall.allowedTCPPortRanges = [{ from = 8000; to = 8999; }];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
