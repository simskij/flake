{ inputs, lib, config, pkgs, ... }: {

  wayland = {
    windowManager = {
      sway = {
        enable = true;
        wrapperFeatures = { gtk = true; };
          config = {
            gaps = {
              outer = 5;
              inner = 10;
            };
            bars = [];
            input = {
              "type:keyboard" = {
                xkb_layout = "us";
                xkb_variant = "mac";
              };
            };
            output = {
              "*" = {
                bg = "/home/simme/.wallpaper.png fill";
                scale = "1";
              };
              "HDMI-A-1" = {
                mode = "3440x1440 pos 0 0";
              };
              "DP-4" = {
                transform = "90 pos 3440 0"; 
              };  
            };
            keybindings = {
              "$mod+space" = "exec $menu";
              "$mod+return" = "exec $term";
              "$mod+Shift+c" = "reload";
              "$mod+Shift+q" = "kill";
              "$mod+Left" = "focus left";
              "$mod+Down" = "focus down";
              "$mod+Up" = "focus up";
              "$mod+Right" = "focus right";
              "$mod+Shift+Left" = "move left";
              "$mod+Shift+Down" = "move down";
              "$mod+Shift+Up" = "move up";
              "$mod+Shift+Right" = "move right";
              "$mod+1" = "workspace 1";
              "$mod+2" = "workspace 2";
              "$mod+3" = "workspace 3";
              "$mod+4" = "workspace 4";
              "$mod+5" = "workspace 5";
              "$mod+6" = "workspace 6";
              "$mod+7" = "workspace 7";
              "$mod+8" = "workspace 8";
              "$mod+9" = "workspace 9";
              "$mod+0" = "workspace 10";
              "$mod+Shift+1" = "move container to workspace 1";
              "$mod+Shift+2" = "move container to workspace 2";
              "$mod+Shift+3" = "move container to workspace 3";
              "$mod+Shift+4" = "move container to workspace 4";
              "$mod+Shift+5" = "move container to workspace 5";
              "$mod+Shift+6" = "move container to workspace 6";
              "$mod+Shift+7" = "move container to workspace 7";
              "$mod+Shift+8" = "move container to workspace 8";
              "$mod+Shift+9" = "move container to workspace 9";
              "$mod+Shift+0" = "move container to workspace 10";
              
              "$mod+b" = "splith";
              "$mod+v" = "splitv";
              "$mod+s" = "layout stacking"; 
              "$mod+w" = "layout tabbed"; 
              "$mod+e" = "layout toggle split"; 
              "$mod+f" = "fullscreen";
              "$mod+Shift+space" = "floating toggle";
              "$mod+Shift+f" = "focus mode_toggle";
              "$mod+a" = "focus parent";
              "$mod+Shift+e" = ''
                exec swaynag \
                  -t warning \
                  -m 'Really?' \
                  -B 'Yes, exit sway' \
                  'swaymsg exit'
              '';
            };
          };
          extraConfigEarly = ''
            exec dbus-update-activation-environment --systemd \
              DISPLAY \
              WAYLAND_DISPLAY \
              SWAYSOCK \
              XDG_CURRENT_DESKTOP

            exec GDK_BACKEND=wayland ulauncher --hide-window

            set $term kitty
            set $mod mod4
            set $menu ulauncher-toggle

            floating_modifier $mod normal

            default_border none 0

            for_window {
                [app_id="ulauncher"] floating enable, border none
            }
          '';
      
      };
    };
  };
}