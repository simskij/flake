{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.arctic.desktop.addons.mako;
in
  with lib;
{
  options.arctic.desktop.addons.mako = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager = {
      users = {
        "${username}" = {
          services = {
            mako = {
              enable = true;
              textColor = "#cdd6f4";
              backgroundColor = "#1e1e2e";
              borderColor = "#89b4fa";
              defaultTimeout = 5000;
              progressColor = "#313244";
              extraConfig = ''
                [urgency=high]
                border-color=#fab387
              '';
            };
          };
        };
      };
    };
  };
}
