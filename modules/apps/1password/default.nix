{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.arctic.apps.onepassword;
in
  with lib;
{
  options.arctic.apps.onepassword = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    programs = {
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ username ];
      };
    };
  };
}
