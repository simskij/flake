{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.arctic.apps.starq;
in
  with lib;
{
  options.arctic.apps.starq.enable = mkEnableOption "";

  config = mkIf cfg.enable {
    home-manager = {
      users = {
        "${username}" = {
          home = {
            packages = with pkgs; [
              jq
              yq
              xq
            ];
          };
        };
      };
    };
  };
}
