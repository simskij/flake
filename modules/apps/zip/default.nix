{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.arctic.apps.zip;
in
  with lib;
{
  options = {
    arctic = {
      apps = {
        zip = {
          enable = mkEnableOption "";
        };
      }; 
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      zip
      unzip
      unrar
    ];
  };
}
