{
  lib,
  config,
  pkgs,
  username,
  stateVersion,
  ...
}:
let
  cfg = config.arctic.packages;
in
  with lib;
{
  options.arctic.packages = mkOption {
    type = types.listOf types.attrs;
    default = [];
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users = {
        "${username}" = {
          home = {
            stateVersion = stateVersion;
            packages = cfg;
          };
        };
      };
    };
  };
}

