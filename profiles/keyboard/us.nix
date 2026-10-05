{...}: {
  console.keyMap = "us";

  hm.xdg.configFile."niri/keyboard.kdl".text = ''
    input {
      keyboard {
        xkb {
          layout "us"
          options "compose:ralt"
        }
      }
    }
  '';
}
