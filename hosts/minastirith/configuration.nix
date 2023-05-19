{ config, inputs, pkgs, ... }:

{
  edu = {
    services = {
      djtobis.enable = true;
      pombobot.enable = true;
    };

    graphical = {
      gnome.enable = true;
      games.enable = true;
    };

    editors.intellij.enable = true;
    noautosuspend.enable = true;

    shell = {
      fish.enable = true;
      gpg.enable = true;
      git.enable = true;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

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
    passwordAuthentication = false;
  };

  usr.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIX4tRQIEAQiP2mesP0t0uCnw3micTnKxxSW22N5MhFw eduardo@iphone"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDi3n8aFv3+KeaRWbwXkiss9kWCfkNVPpoZ0gpC+QMYR eduardo@ipad"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDr6cqDPQKapijMfCxwXAFSniL5Tl1WMMcJ1dUcB3yhy eduardo@annuminas"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0/hgrBsENtRhS2KxIsZrXiW5vVlkwxGCCQ14TUtGVd eduardo@dolamroth"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9fsZ6NiBTcHQlT7GvX0gjMXkVB1FA4d0ryckaTIod2 eduardo@fornost"
  ];

  users.users.intruso = {
    isNormalUser = true;
    extraGroups = [ "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDC1ev5H1DVj45UeBOB/T05Zr07dzbmiY3iBB1aX6b/LnrRx/Qdsd+UeOGee6xJhGhcmm2QKXTwSCVohOP1Zg2joNLPCJUJb6HJGt4dIgiQVuPLPqiJsWsI4MrFbH9gMei6CuJY6rFtKJudHbfTq3+hUyLrB3aQtNaT0q/7e4atsQT6hAt43rQy9U2nPiB26khfebdoLeCb1tXkOd6IeU2Ofq2q00KwpuyfcGb0hQOUptc5haQT0xDzpSJDguw/0GAKcMnhhzBIaoF7J5b45vAS3SA0jQhXfGpb6IuzJ70yuxo5zgtCN8/Viv8ofW9IsrEFnF7CdSYGthhdcsVs2oPD03FX1twD0QvTQkkTnv4Jb7L2aSlSUy7UIPYKWyDH/6m1JOZZvbf+0KbkB9S+Jw99TILiyeGKMZBV64XzdJOwq0OEEmSqCOgopyGRokua7BpBsUesO+m2tcLXVfoLAnOb9IkxiEYprrV16FqZV7TUgi+3daWGAleeL0twd9w/Oy6kj2nhZ2NmYXrLDbppz4IHG6JRCGHsKomlKSsPC6MMnGch7m43JLIWBqF1l3gHFS+XOxqXv+jyb4Sou/yPOHNfQPDEw6TGblG4PFk2lsqaB/brkrFlkFCeDRbya03Bb29cpsNjVSV4XHNP0yhux1qbOC232QFK3wIOKx5ExLGBPw== diogosantoss360@gmail.com"
    ];
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 31001 ];
  networking.firewall.allowedUDPPorts = [ 31001 ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
