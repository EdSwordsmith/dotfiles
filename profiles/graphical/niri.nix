{
  pkgs,
  profiles,
  wallpaper,
  ...
}: {
  imports = with profiles.graphical; [
    common
    alacritty
    waybar
    wleave
  ];

  programs.niri.enable = true;

  hm.services.mako = {
    enable = true;
    settings = {
      font = "monospace 12";
      layer = "overlay";
    };
  };

  environment.systemPackages = with pkgs; [
    bemenu
    j4-dmenu-desktop
    wdisplays
    wl-clipboard
    swaylock
    nautilus
    qview
    swaybg
    xwayland-satellite
  ];

  programs.nm-applet.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Solves small cursor on HiDPI.
  hm.home.pointerCursor = {
    gtk.enable = true;

    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Bibata-Modern-Classic";
    };
  };

  hm.services.gammastep = {
    enable = true;
    tray = true;
    provider = "manual";
    latitude = 38.7;
    longitude = -9.14;
    temperature = {
      day = 5700;
      night = 2700;
    };
  };

  hm.services.swayidle = {
    enable = true;
    events = {
      "before-sleep" = "${pkgs.swaylock}/bin/swaylock --color 000000";
      lock = "${pkgs.swaylock}/bin/swaylock --color 000000";
    };
    timeouts = [
      {
        timeout = 900;
        command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
        resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r";
      }
      {
        timeout = 910;
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
      }
      {
        timeout = 920;
        command = "${pkgs.swaylock}/bin/swaylock --color 000000";
      }
    ];
  };

  hm.xdg.configFile."niri/config.kdl".text = ''
    input {
        keyboard {
            xkb {
                layout "pt"
            }
        }

        touchpad {
            tap
            click-method "clickfinger"
            natural-scroll
        }

        focus-follows-mouse
    }

    output "eDP-1" {
        mode "1920x1080"
        scale 1
        position x=0 y=0
    }

    layout {
        gaps 0
        center-focused-column "never"
        default-column-width { proportion 0.5; }

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        focus-ring {
            off
        }

        border {
            width 2
            active-color "#ffffff"
            inactive-color "#000000"
        }
    }

    spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "-i" "${wallpaper}" "-m" "fill"
    spawn-at-startup "${pkgs.xwayland-satellite}/bin/xwayland-satellite"

    prefer-no-csd
    screenshot-path null

    animations {
        slowdown 0.75
    }

    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        open-floating true
    }

    binds {
        Mod+Shift+Return { show-hotkey-overlay; }

        Mod+Return repeat=false { spawn "${pkgs.alacritty}/bin/alacritty"; }
        Mod+D { spawn "${pkgs.j4-dmenu-desktop}/bin/j4-dmenu-desktop" "--dmenu=${pkgs.bemenu}/bin/bemenu -i --fn 'JetBrains Mono 12' --nb '#0A0E14' --nf '#B3B1AD' --sb '#F9AF4F' --sf '#0A0E14' --hb '#F9AF4F' --hf '#0A0E14' --tf '#F9AF4F' -H 30 --hp 12" "--term=${pkgs.alacritty}/bin/alacritty"; }
        Mod+Escape { spawn "${pkgs.swaylock}/bin/swaylock" "--color" "000000"; }
        Mod+Shift+Escape { spawn "wleave"; }
        Mod+Shift+Q { close-window; }
        Mod+Tab { toggle-overview; }

        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+V { toggle-window-floating; }
        Mod+W { toggle-column-tabbed-display; }
        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-column-width-back; }
        Mod+Comma { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-or-workspace-down; }
        Mod+Up    { focus-window-or-workspace-up; }
        Mod+Right { focus-column-right; }
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-or-workspace-down; }
        Mod+K     { focus-window-or-workspace-up; }
        Mod+L     { focus-column-right; }

        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Down  { move-window-down; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+H     { move-column-left; }
        Mod+Shift+J     { move-window-down; }
        Mod+Shift+K     { move-window-up; }
        Mod+Shift+L     { move-column-right; }

        Mod+Ctrl+Left  { move-column-to-monitor-left; }
        Mod+Ctrl+Down  { move-column-to-monitor-down; }
        Mod+Ctrl+Up    { move-column-to-monitor-up; }
        Mod+Ctrl+Right { move-column-to-monitor-right; }
        Mod+Ctrl+H     { move-column-to-monitor-left; }
        Mod+Ctrl+J     { move-column-to-monitor-down; }
        Mod+Ctrl+K     { move-column-to-monitor-up; }
        Mod+Ctrl+L     { move-column-to-monitor-right; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+0 { focus-workspace 10; }

        Mod+Alt+Down { focus-workspace-down; }
        Mod+Alt+Up   { focus-workspace-up; }
        Mod+Alt+J    { focus-workspace-down; }
        Mod+Alt+K    { focus-workspace-up; }
        Mod+Alt+Shift+Down { move-column-to-workspace-down; }
        Mod+Alt+Shift+Up   { move-column-to-workspace-up; }
        Mod+Alt+Shift+J    { move-column-to-workspace-down; }
        Mod+Alt+Shift+K    { move-column-to-workspace-up; }

        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }
        Mod+Shift+0 { move-column-to-workspace 10; }

        Print { screenshot; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn "${pkgs.pamixer}/bin/pamixer" "--increase" "5"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "${pkgs.pamixer}/bin/pamixer" "--decrease" "5"; }
        XF86AudioMute allow-when-locked=true { spawn "${pkgs.pamixer}/bin/pamixer" "-t"; }
        XF86AudioMicMute allow-when-locked=true { spawn "${pkgs.pamixer}/bin/pamixer" "--default-source" "-t"; }

        XF86MonBrightnessDown allow-when-locked=true { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%-"; }
        XF86MonBrightnessUp allow-when-locked=true { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "+5%"; }
    }
  '';
}
