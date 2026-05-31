{pkgs, ...}: {
  hm.programs.wleave = {
    enable = true;
    settings = {
      buttons-per-row = "3";
      buttons = [
        {
          label = "lock";
          action = "swaylock --color 000000";
          text = "Lock";
          keybind = "l";
          icon = "${pkgs.wleave}/share/wleave/icons/lock.svg";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
          keybind = "h";
          icon = "${pkgs.wleave}/share/wleave/icons/hibernate.svg";
        }
        {
          label = "logout";
          action = "loginctl terminate-user $USER";
          text = "Logout";
          keybind = "e";
          icon = "${pkgs.wleave}/share/wleave/icons/logout.svg";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
          icon = "${pkgs.wleave}/share/wleave/icons/shutdown.svg";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspend";
          keybind = "u";
          icon = "${pkgs.wleave}/share/wleave/icons/suspend.svg";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
          icon = "${pkgs.wleave}/share/wleave/icons/reboot.svg";
        }
      ];
    };

    # style = ''
    #   * {
    #     background-image: none;
    #   }

    #   window {
    #     background-color: rgba(12, 12, 12, 0.9);
    #   }

    #   button {
    #     color: #FFFFFF;
    #     background-color: #1E1E1E;
    #     border-style: solid;
    #     border-width: 2px;
    #     background-repeat: no-repeat;
    #     background-position: center;
    #     background-size: 25%;
    #   }

    #   button:focus, button:active, button:hover {
    #     background-color: #195299;
    #     outline-style: none;
    #   }
    # '';
  };
}
