{...}: {
  hm.services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "undocked";
          outputs = [
            {
              criteria = "eDP-1";
              mode = "1920x1080@60Hz";
              position = "0,0";
              scale = 1.0;
            }
          ];
        };
      }
      {
        profile = {
          name = "docked";
          outputs = [
            {
              criteria = "Dell Inc. DELL U2725QE B9Y5484";
              mode = "3840x2160@60Hz";
              position = "0,0";
              scale = 1.5;
            }
            {
              criteria = "eDP-1";
              mode = "1920x1080@60Hz";
              position = "320,1440";
              scale = 1.0;
            }
          ];
        };
      }
    ];
  };
}
