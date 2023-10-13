{pkgs, ...}: {
  
  home.file = {
  };
  home.packages = with pkgs; [
    hyprpaper
    hyprpicker
  ];

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        recommendedEnvironment = true;
        xwayland = {
          enable = true;
        };
        extraConfig = ''

          monitor = HDMI-A-1, preferred, 0x0, 1
          monitor = DP-4, preferred, 3440x0, 1, transform, 3
          
          workspace = 1, monitor:HDMI-A-1
          workspace = name:Left, default:true
          workspace = 2, monitor:HDMI-A-1
          workspace = 3, monitor:HDMI-A-1
          workspace = 4, monitor:HDMI-A-1
          workspace = 5, monitor:HDMI-A-1
          workspace = 6, monitor:DP-4, default:true
          workspace = 7, monitor:DP-4
          workspace = 8, monitor:DP-4
          workspace = 9, monitor:DP-4
          workspace = 10, monitor:DP-4

         
          exec-once = hyprpaper
          exec-once = 1password --silent
          exec-once = ulauncher --hide-window

          $mod = SUPER
          bind = ,XF86AudioRaiseVolume, exec, playerctl -a volume 0.1+
          bind = ,XF86AudioLowerVolume, exec, playerctl -a volume 0.1-
          bind = $mod SHIFT, P, exec, hyprprop > ~/props.log
          bind = $mod, RETURN, exec, kitty
          bind = $mod, SPACE, exec, ulauncher-toggle
          bind = $mod, backslash, exec, 1password --toggle
          bind = $mod SHIFT, Q, killactive
          bind = $mod, F, fullscreen
          bind = $mod SHIFT, Space, togglefloating
          bind = $mod, A, togglesplit
          bind = $mod SHIFT, L, exec, ~/.config/hypr/lock.sh 
          bind = $mod, left, movefocus, l
          bind = $mod, right, movefocus, r
          bind = $mod, up, movefocus, u
          bind = $mod, down, movefocus, d
          bind = $mod CTRL, RETURN, exec, playerctl --player spotify,mpd play-pause 
          bind = $mod CTRL, LEFT, exec, playerctl --player spotify,mpd previous
          bind = $mod CTRL, RIGHT, exec, playerctl --player spotify,mpd next
          bind = $mod CTRL, UP, exec, playerctl volume 0.1+
          bind = $mod CTRL, DOWN, exec, playerctl volume 0.1-

          bind = $mod SHIFT, left, movewindow, l
          bind = $mod SHIFT, right, movewindow, r
          bind = $mod SHIFT, up, movewindow, u
          bind = $mod SHIFT, down, movewindow, d

          bindm = SUPER, mouse:272, movewindow
          bindm = SUPER, mouse:273, resizewindow

          bind = $mod, 1, workspace, 1
          bind = $mod, 2, workspace, 2
          bind = $mod, 3, workspace, 3
          bind = $mod, 4, workspace, 4
          bind = $mod, 5, workspace, 5
          bind = $mod, 6, workspace, 6
          bind = $mod, 7, workspace, 7
          bind = $mod, 8, workspace, 8
          bind = $mod, 9, workspace, 9
          bind = $mod, 0, workspace, 10

          bind = $mod SHIFT, 1, movetoworkspace, 1
          bind = $mod SHIFT, 2, movetoworkspace, 2
          bind = $mod SHIFT, 3, movetoworkspace, 3
          bind = $mod SHIFT, 4, movetoworkspace, 4
          bind = $mod SHIFT, 5, movetoworkspace, 5
          bind = $mod SHIFT, 6, movetoworkspace, 6
          bind = $mod SHIFT, 7, movetoworkspace, 7
          bind = $mod SHIFT, 8, movetoworkspace, 8
          bind = $mod SHIFT, 9, movetoworkspace, 9
          bind = $mod SHIFT, 0, movetoworkspace, 10
        
          general {
            no_border_on_floating = true
            border_size = 0
            gaps_in = 8
            gaps_out = 16
          }

          decoration {
            rounding = 8
            drop_shadow = false
          }

          animations {
            enabled = true
            animation = border,1,2,default
            animation = fade,1,2,default
            animation = workspaces,1,3,default
            animation = specialWorkspace,1,5,default,fade
          }

          input {
            kb_variant = mac
          }

          windowrulev2 = float, class:^(ulauncher)$
          windowrulev2 = workspace special silent, title:^(Firefox — Sharing Indicator)$
          windowrulev2 = workspace special silent, title:^(.*is sharing (your screen|a window)\.)$

          exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        '';
      };
    };
  };
  home.file = {

    ".config/hypr/hyprpaper.conf" = {
      text = ''
        preload = /home/simme/.wallpaper.png
        wallpaper = HDMI-A-1,/home/simme/.wallpaper.png
        wallpaper = DP-4,/home/simme/.wallpaper.png
      '';
    };

    ".config/hypr/lock.sh" = {
      executable = true;
      text = ''
      swayidle \
          timeout 60 'hyprctl dispatch dpms off' \
          resume 'hyprctl dispatch dpms on;' & 
      
      swaylock -c 000000ff --image ~/.wallpaper.png
      killall swayidle -9 
      '';
    };
  };
}
