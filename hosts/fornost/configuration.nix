{
  pkgs,
  profiles,
  ...
}: {
  imports = with profiles; [
    dev.common
    shell.git.common
    shell.git.signing
    shell.fish
    shell.zsh

    graphical.games
    graphical.niri

    editors.emacs

    tailscale

    private.elessar
  ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hm.services.blueman-applet.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  services.fprintd.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  services.resolved.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Configure keymap
  console.keyMap = "pt-latin1";
  services.xserver.xkb = {
    layout = "pt";
    variant = "";
  };

  usr.shell = pkgs.fish;
  usr.extraGroups = ["dialout" "libvirtd" "kvm"];

  virtualisation.podman.enable = true;

  age.identityPaths = [
    "/home/eduardo/.ssh/id_ed25519"
  ];

  networking.firewall.allowedTCPPortRanges = [
    {
      from = 8000;
      to = 8999;
    }
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
