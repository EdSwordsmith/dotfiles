{...}: {
  console.keyMap = "pt-latin1";

  hm.xdg.configFile."niri/keyboard.kdl".text = ''
    input {
      keyboard {
        xkb {
          layout "pt,us"
        }
      }
    }

    binds {
      Mod+Space {
        switch-layout "next";
      }
    }
  '';
}
