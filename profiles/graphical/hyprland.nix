{
  profiles,
  pkgs,
  wallpaper,
  configDir,
  ...
}: {
  imports = with profiles.graphical; [
    common
    alacritty
    waybar
    wlogout
    hypridle
    hyprlock
  ];

  programs.hyprland.enable = true;

  hm.services.swaync.enable = true;

  environment.systemPackages = with pkgs; [
    blueberry
    wdisplays
    wl-clipboard
    sway-contrib.grimshot
    gnome.nautilus
    feh
  ];

  programs.nm-applet.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  hm.programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "${configDir}/theme.rasi";
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

  hm.wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };

    extraConfig = ''
      ################
      ### MONITORS ###
      ################

      monitor = eDP-1, 1920x1080, 0x0, 1
      monitor = ,preferred, auto, auto

      ###################
      ### MY PROGRAMS ###
      ###################

      $terminal = alacritty
      $menu = rofi -show drun -show-icons
      $screenshot = ${pkgs.sway-contrib.grimshot}/bin/grimshot save anything - | ${pkgs.satty}/bin/satty -f - --fullscreen --copy-command ${pkgs.wl-clipboard}/bin/wl-copy --early-exit
      $logout = wlogout -p layer-shell

      #####################
      ### LOOK AND FEEL ###
      #####################

      general {
          gaps_in = 4
          gaps_out = 8
          border_size = 2

          col.active_border = rgba(ffffffff)
          col.inactive_border = rgba(000000ff)

          resize_on_border = true
          allow_tearing = false
          layout = dwindle
      }

      decoration {
          rounding = 8

          active_opacity = 1.0
          inactive_opacity = 1.0

          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)

          blur {
              enabled = true
              size = 3
              passes = 1

              vibrancy = 0.1696
          }
      }

      animations {
          enabled = true

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 4, myBezier
          animation = windowsOut, 1, 4, default, popin 80%
          animation = border, 1, 7, default
          animation = borderangle, 1, 5, default
          animation = fade, 1, 4, default
          animation = workspaces, 1, 3, default
      }

      dwindle {
          preserve_split = true
          no_gaps_when_only = 2
      }

      misc {
          disable_hyprland_logo = true
      }

      group {
          col.border_active = rgba(ffffffff)
          col.border_inactive = rgba(000000ff)
          col.border_locked_active = rgba(ffffffff)
          col.border_locked_inactive = rgba(000000ff)

          groupbar {
              font_size = 12
              col.active = rgba(222222ff)
              col.inactive = rgba(111111ff)
              col.locked_active = rgba(222222ff)
              col.locked_inactive = rgba(111111ff)
          }
      }

      #############
      ### INPUT ###
      #############

      input {
          kb_layout = pt
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

          touchpad {
              natural_scroll = true
              clickfinger_behavior = true
              tap-to-click = true
          }
      }

      gestures {
          workspace_swipe = false
      }

      ####################
      ### KEYBINDINGSS ###
      ####################

      $mainMod = SUPER

      bind = $mainMod, Return, exec, $terminal
      bind = $mainMod SHIFT, Q, killactive,
      bind = $mainMod, Escape, exec, loginctl lock-session
      bind = $mainMod SHIFT, Escape, exec, $logout
      bind = $mainMod, F, fullscreen
      bind = $mainMod, W, togglegroup
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, D, exec, $menu

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, changegroupactive, b
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, changegroupactive, f
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Move focus with mainMod + hjkl keys
      bind = $mainMod, H, changegroupactive, b
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, changegroupactive, f
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d

      # Move windows with mainMod + arrow keys
      bind = $mainMod SHIFT, left, movewindoworgroup, l
      bind = $mainMod SHIFT, right, movewindoworgroup, r
      bind = $mainMod SHIFT, up, movewindoworgroup, u
      bind = $mainMod SHIFT, down, movewindoworgroup, d

      # Move windows with mainMod + hjkl keys
      bind = $mainMod SHIFT, H, movewindoworgroup, l
      bind = $mainMod SHIFT, L, movewindoworgroup, r
      bind = $mainMod SHIFT, K, movewindoworgroup, u
      bind = $mainMod SHIFT, J, movewindoworgroup, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10

      # Move to different monitor
      bind = $mainMod CTRL, left, movecurrentworkspacetomonitor, l
      bind = $mainMod CTRL, down, movecurrentworkspacetomonitor, d
      bind = $mainMod CTRL, up, movecurrentworkspacetomonitor, u
      bind = $mainMod CTRL, right, movecurrentworkspacetomonitor, r
      bind = $mainMod CTRL, H, movecurrentworkspacetomonitor, l
      bind = $mainMod CTRL, J, movecurrentworkspacetomonitor, d
      bind = $mainMod CTRL, K, movecurrentworkspacetomonitor, u
      bind = $mainMod CTRL, L, movecurrentworkspacetomonitor, r

      # Example special workspace (scratchpad)
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspacesilent, special:magic

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Screenshots
      bind =, Print, exec, $screenshot

      # Sound
      bindel =, XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer --increase 5
      bindel =, XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer --decrease 5
      bindel =, XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t
      bindel =, XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source -t

      # Brightness
      bindel =, XF86MonBrightnessDown, exec, ${pkgs.light}/bin/light -T 0.72
      bindel =, XF86MonBrightnessUp, exec, ${pkgs.light}/bin/light -T 1.4

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      windowrulev2 = suppressevent maximize, class:.*
    '';
  };

  hm.services.hyprpaper = {
    enable = true;
    settings = {
      preload = "${wallpaper}";
      wallpaper = ", ${wallpaper}";
    };
  };
}
