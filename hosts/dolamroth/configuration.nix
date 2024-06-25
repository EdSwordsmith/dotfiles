{
  config,
  pkgs,
  profiles,
  secretsDir,
  ...
}: {
  imports = with profiles; [
    server
    shell.zsh
    editors.neovim
    editors.emacs
    graphical.sway
    tailscale
    services.djtobis
  ];

  edu.shell.git.enable = true;

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
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBMtO8MwCwyNu8DN1bcX1cdswh6iYkB5yRpGaPed6RwrsM99DPwBb3qE38jK9v76gd4iIjD1f2KdYkQtkCOEI3Zk= eduardo@termius"
  ];

  # ACME Certificates
  age.secrets.cloudflare.file = "${secretsDir}/cloudflare.age";
  security.acme = {
    acceptTerms = true;
    defaults.email = "self@espadeiro.pt";

    certs."espadeiro.pt" = {
      domain = "espadeiro.pt";
      extraDomainNames = ["*.espadeiro.pt"];
      dnsProvider = "cloudflare";
      dnsPropagationCheck = true;
      credentialsFile = config.age.secrets.cloudflare.path;
    };
  };

  users.users.nginx.extraGroups = ["acme"];

  # Nextcloud
  age.secrets.ncdbpass = {
    file = "${secretsDir}/ncdbpass.age";
    owner = "nextcloud";
    group = "nextcloud";
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    hostName = "cloud.espadeiro.pt";
    https = true;
    config.adminpassFile = config.age.secrets.ncdbpass.path;
  };

  services.nginx.enable = true;
  services.nginx.virtualHosts."cloud.espadeiro.pt" = {
    forceSSL = true;
    useACMEHost = "espadeiro.pt";
    # locations."/".proxyPass = "http://127.0.0.1:80";
  };

  systemd.services.gtnh = {
    path = with pkgs; [jre];
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    serviceConfig = {
      ExecStart = "/home/eduardo/minecraft/gtnh/startserver-java9.sh";
      WorkingDirectory = "/home/eduardo/minecraft/gtnh";
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
