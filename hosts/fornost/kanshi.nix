{
  config,
  options,
  pkgs,
  lib,
  inputs,
  configDir,
  secretsDir,
  ...
}: {
  hm.services.kanshi = {
    enable = true;
    profiles = {
      normal = {
        outputs = [
          {
            criteria = "eDP-1";
            position = "0,0";
          }
        ];
      };

      dei = {
        outputs = [
          {
            criteria = "Samsung Electric Company LS32A600U HNTR600083";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            position = "0,1440";
          }
        ];
      };

      dei_triple = {
        outputs = [
          {
            criteria = "Ancor Communications Inc ASUS VS247 F9LMTF092353";
            position = "0,360";
            mode = "1920x1080";
          }
          {
            criteria = "Samsung Electric Company LS32A600U HNTR600083";
            position = "1920,0";
          }
          {
            criteria = "eDP-1";
            position = "1920,1440";
          }
        ];
      };
    };
  };
}
