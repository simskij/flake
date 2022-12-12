{ inputs, lib, config, pkgs, ... }: {
  programs = {
    waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = "sway-session.target";
      };
      settings = [{
        height = 40;
        layer = "top";
        position = "bottom";
        tray = { spacing = 10; };
        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "sway/window"
        ];
        modules-right = [
          "tray"
          "clock"
        ];
      }];
    };
  };
}
