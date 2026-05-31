{
  config,
  pkgs,
  profiles,
  secretsDir,
  ...
}: {
  imports = with profiles; [
    server
    shell.git.common
    shell.zsh
    editors.emacs
    graphical.niri
    tailscale
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Configure keymap
  console.keyMap = "pt-latin1";
  services.xserver.xkb = {
    layout = "pt";
    variant = "";
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  usr.shell = pkgs.zsh;
  usr.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDr6cqDPQKapijMfCxwXAFSniL5Tl1WMMcJ1dUcB3yhy eduardo@annuminas"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9fsZ6NiBTcHQlT7GvX0gjMXkVB1FA4d0ryckaTIod2 eduardo@fornost"
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBMtO8MwCwyNu8DN1bcX1cdswh6iYkB5yRpGaPed6RwrsM99DPwBb3qE38jK9v76gd4iIjD1f2KdYkQtkCOEI3Zk= eduardo@iphone"
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDfATrcDeEWGJrjyfJcQwaUqgPTuN2LRPmtephSAKwL/MfaNw/t7PUDqctarnJsWxYG84GXobG63vt/jEjMSKPo= eduardo@ipad"
  ];

  # systemd.services.gtnh = {
  #   path = with pkgs; [unstable.jdk25];
  #   wantedBy = ["multi-user.target"];
  #   after = ["network.target"];
  #   serviceConfig = {
  #     ExecStart = "/home/eduardo/minecraft/gtnh/startserver-java9.sh";
  #     WorkingDirectory = "/home/eduardo/minecraft/gtnh";
  #   };
  # };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
  };

  services.meadhal = {
    enable = true;
    host = "mead.espadeiro.pt";
  };

  age.secrets.cftunnel.file = "${secretsDir}/cftunnel.age";
  services.cloudflared = {
    enable = true;
    tunnels = {
      "85aa279b-8295-4c80-8f37-0e5b5182e854" = {
        credentialsFile = "${config.age.secrets.cftunnel.path}";
        default = "http_status:404";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [80 443 25565];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
