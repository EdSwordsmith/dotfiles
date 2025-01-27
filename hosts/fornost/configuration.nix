{
  pkgs,
  profiles,
  ...
}: {
  imports = with profiles; [
    dev
    shell.fish
    shell.zsh

    graphical.games
    graphical.hyprland

    editors.emacs
    editors.neovim

    tailscale
  ];

  edu = {
    services.wgrnl = {
      enable = true;
      privateKeyFile = "/etc/wireguard/privkey";
    };

    shell.git = {
      enable = true;
      signing = true;
    };
  };

  # boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.bluetooth.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [virt-manager];

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

  usr.shell = pkgs.zsh;
  usr.extraGroups = ["dialout" "docker" "libvirtd"];

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
