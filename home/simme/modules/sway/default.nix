{ inputs, lib, config, pkgs, ... }: {

  gtk = {
    enable = true;
    font.name = "Victor Mono SemiBold 12";
    theme = {
      name = "Catppuccin-Pink-Dark";
      package = pkgs.catppuccin-gtk;
    };
  };

  programs = {
    waybar = {
      enable = true;
      settings = [{
        height = 40;
        layer = "top";
        position = "top";
        margin = "15 15 0 15";
        tray = { spacing = 10; };
        modules-left = [
          "clock"
          "sway/mode"
        ];
        modules-center = [
          "sway/workspaces"        
        ];
        modules-right = [
          "pulseaudio"
          "tray"
        ];
        "sway/workspaces" = {
            "format" = "⬤";
              "persistent_workspaces" = {
                "1" = [ "HDMI-A-1" ];
                "2" = [ "HDMI-A-1" ];
                "3" = [ "HDMI-A-1" ];
                "4" = [ "HDMI-A-1" ];
                "5" = [ "HDMI-A-1" ];
                "6" =  [ "DP-4" ];
                "7" =  [ "DP-4" ];
                "8" =  [ "DP-4" ];
                "9" =  [ "DP-4" ];
                "10"= [ "DP-4" ];
              };
            };
      }];
      style = import ./waybar.style.nix {};
    };
  };
  home.file = {
    ".config/sway/lock.sh" = {
      executable = true;
      text = ''
        swayidle \
            timeout 1 'swaymsg "output * dpms off"' \
            resume 'swaymsg "output * dpms on"' & 
        swaylock -c 000000ff --image ~/.wallpaper.png
        kill %%
      '';
    };
  };

  wayland = {
    windowManager = {
      sway = {
        enable = true;
        systemdIntegration = true;
        wrapperFeatures = { gtk = true; };
        config = {
          menu = "ulauncher-toggle";
          terminal = "kitty";
          modifier = "Mod4";
          window = {
            hideEdgeBorders = "both";
          };
          floating = {
            modifier = "Mod4";
            border = 0;
            criteria = [
              { app_id = "ulauncher"; }
              { class = "^Steam$"; }
              { class = "^Wine$"; }
            ];
          };
          gaps = {
            outer = 5;
            inner = 10;
          };
          bars = [ 
            {
              command = "waybar";
            }
          ];
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
          keybindings = with config.wayland.windowManager.sway.config; {
            "${modifier}+space" = "exec ${menu}";
            "${modifier}+return" = "exec ${terminal}";
            "${modifier}+Shift+c" = "reload";
            "${modifier}+Shift+q" = "kill";
            "${modifier}+Left" = "focus left";
            "${modifier}+Down" = "focus down";
            "${modifier}+Up" = "focus up";
            "${modifier}+Right" = "focus right";
            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Down" = "move down";
            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+Right" = "move right";
            "${modifier}+1" = "workspace 1";
            "${modifier}+2" = "workspace 2";
            "${modifier}+3" = "workspace 3";
            "${modifier}+4" = "workspace 4";
            "${modifier}+5" = "workspace 5";
            "${modifier}+6" = "workspace 6";
            "${modifier}+7" = "workspace 7";
            "${modifier}+8" = "workspace 8";
            "${modifier}+9" = "workspace 9";
            "${modifier}+0" = "workspace 10";
            "${modifier}+Shift+1" = "move container to workspace 1";
            "${modifier}+Shift+2" = "move container to workspace 2";
            "${modifier}+Shift+3" = "move container to workspace 3";
            "${modifier}+Shift+4" = "move container to workspace 4";
            "${modifier}+Shift+5" = "move container to workspace 5";
            "${modifier}+Shift+6" = "move container to workspace 6";
            "${modifier}+Shift+7" = "move container to workspace 7";
            "${modifier}+Shift+8" = "move container to workspace 8";
            "${modifier}+Shift+9" = "move container to workspace 9";
            "${modifier}+Shift+0" = "move container to workspace 10";
            "${modifier}+b" = "splith";
            "${modifier}+v" = "splitv";
            "${modifier}+s" = "layout stacking";
            "${modifier}+w" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";
            "${modifier}+f" = "fullscreen";
            "${modifier}+Shift+space" = "floating toggle";
            "${modifier}+Shift+f" = "focus mode_toggle";
            "${modifier}+a" = "focus parent";
            "${modifier}+Mod1+3" = "exec grim - | wl-copy -t image/png";
            "${modifier}+Mod1+4" = "exec grim -g \"$(slurp -d)\" - | wl-copy -t image/png";
            "${modifier}+l" = "exec ~/.config/sway/lock.sh";
            # "exec ";
            "${modifier}+Shift+e" = ''
              exec swaynag \
                -t warning \
                -m 'Really?' \
                -B 'Yes, exit sway' \
                'swaymsg exit'
            '';
          };
        };
        extraConfigEarly = ''
          exec GDK_BACKEND=wayland ulauncher --hide-window
          exec wlsunset
          default_border none 0

          workspace 1  output HDMI-A-1
          workspace 2  output HDMI-A-1	 
          workspace 3  output HDMI-A-1	
          workspace 4  output HDMI-A-1	
          workspace 5  output HDMI-A-1	
          workspace 6  output DP-4
          workspace 7  output DP-4
          workspace 8  output DP-4
          workspace 9  output DP-4
          workspace 10 output DP-4
        '';

      };
    };
  };
}
