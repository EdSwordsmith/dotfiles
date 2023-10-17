# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  profiles,
  ...
}: {
  imports = with profiles; [
    shell.fish
    editors.neovim
    graphical.sway
  ];

  edu.shell = {
    git.enable = true;
    gpg.enable = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  usr.shell = pkgs.fish;
  usr.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIX4tRQIEAQiP2mesP0t0uCnw3micTnKxxSW22N5MhFw eduardo@iphone"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDi3n8aFv3+KeaRWbwXkiss9kWCfkNVPpoZ0gpC+QMYR eduardo@ipad"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDr6cqDPQKapijMfCxwXAFSniL5Tl1WMMcJ1dUcB3yhy eduardo@annuminas"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0/hgrBsENtRhS2KxIsZrXiW5vVlkwxGCCQ14TUtGVd eduardo@dolamroth"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9fsZ6NiBTcHQlT7GvX0gjMXkVB1FA4d0ryckaTIod2 eduardo@fornost"
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
