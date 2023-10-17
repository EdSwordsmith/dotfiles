{
  pkgs,
  ...
}: {
  hm.home.packages = with pkgs; [
    prismlauncher
    superTux
    edu.activate-controller
  ];

  programs.steam.enable = true;

  # services.udev.extraRules = ''
  #   ENV{DEVTYPE}=="usb_device", ATTRS{idProduct]=="028e", ATTRS{idVendor}=="045e", ACTION=="add", RUN+="${pkgs.edu.activate-controller}/bin/activate-controller"
  # '';

  services.udev.extraRules = ''
    ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="045e", ACTION=="add", RUN+="${pkgs.edu.activate-controller}/bin/activate-controller"
  '';
}
