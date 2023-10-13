{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.arctic.apps.chromium;
in
  with lib;
{
  options.arctic.apps.chromium = {
    enable = mkEnableOption "";
    extensions = mkOption { type = types.listOf types.str; default = []; };
  };

  config = mkIf cfg.enable {
    home-manager = {
      users = {
        "${username}" = {
            programs = {
              chromium = {
                enable = true;
                extensions = cfg.extensions;
              };
            };
        };
      };
    };
  };
}
