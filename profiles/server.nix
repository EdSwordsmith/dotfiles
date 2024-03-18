{...}: {
  # Disable auto suspend
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  system.autoUpgrade = {
    enable = true;
    flake = "github:EdSwordsmith/dotfiles";
    operation = "boot";

    rebootWindow = {
      lower = "04:00";
      upper = "06:00";
    };

    allowReboot = true;

    flags = [
      # Only use one job to avoid running out of memory and disrupting operations
      "--max-jobs"
      "1"
    ];

    dates = "04:00";
    randomizedDelaySec = "1h";
  };

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    options = "-d"; # delete old generations

    dates = "weekly";
    randomizedDelaySec = "15min";
  };
}
