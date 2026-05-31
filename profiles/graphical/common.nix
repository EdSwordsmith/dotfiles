{
  configDir,
  profiles,
  ...
}: {
  imports = with profiles.graphical; [gtk programs];

  xdg.portal.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "dur_file";
      dur_file_path = "${configDir}/blackhole.dur";
      full_color = true;
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  usr.extraGroups = ["video"]; # For backlight control.
}
