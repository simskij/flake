{
  config,
  pkgs,
  lib,
  username,
  ...
}:
let
  cfg = config.arctic.homebrew;
in
  with lib;
{
  options = {
    arctic = {
      homebrew = {
        enable = mkEnableOption "";
        brews = mkOption { type = types.listOf types.str; default = []; };
        casks = mkOption { type = types.listOf types.str; default = []; };
      };
    };
  };

  config = mkIf cfg.enable {
    nix-homebrew = {
      enable = true;
      enableRosetta = true;
      user = username;
    };

    homebrew = {
      enable = true;
      brews = cfg.brews;
      casks = cfg.casks; 
    };

    services = {
      nix-daemon = {
        enable = true;
      };
    };
  };
}
