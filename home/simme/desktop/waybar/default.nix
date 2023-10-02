{ pkgs, ... }: {
  programs = {
    waybar = {
      enable = true;
      systemd = {
        enable = false;
      };
      settings = [{
        height = 40;
        layer = "top";
        position = "top";
        margin = "15 15 0 15";
        tray = { spacing = 10; };
        modules-left = [
          "clock"
        ];
        modules-center = [
          "wlr/workspaces"        
        ];
        modules-right = [
          "pulseaudio"
          "tray"
        ];
        "wlr/workspaces" = {
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
}
