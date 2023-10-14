{
  config,
  lib,
  username,
  ...
}:
let
  cfg = config.arctic.desktop;
in
  with lib;
{
  options.arctic.desktop = {
    addons = {
      waybar.enable = mkEnableOption "";
    };
  };
  config = mkIf cfg.addons.waybar.enable {
    home-manager = {
      users = {
        "${username}" = {
          programs = {
            waybar = {
              enable = true;
              systemd = {
                enable = true;
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
                "hyprland/workspaces" = {
                  "format" = "⬤";
                  "persistent_workspaces" =
                    with cfg.monitors; {
                      "1" = [ primary   ];
                      "2" = [ primary   ];
                      "3" = [ primary   ];
                      "4" = [ primary   ];
                      "5" = [ primary   ];
                      "6" = [ secondary ];
                      "7" = [ secondary ];
                      "8" = [ secondary ];
                      "9" = [ secondary ];
                      "10"= [ secondary ];
                  };
                };
              }];
              style = import ./style.nix {};
            };
          };
        };
      };
    };
  };
}
