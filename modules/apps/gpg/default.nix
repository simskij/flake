{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.arctic.apps.gpg;
in
  with lib;
{
  options.arctic.apps.gpg = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    programs = {
      gnupg = {
        agent = {
          enable = true;
          enableSSHSupport = config.arctic.network.ssh.enable;
        };
      };
    };
  };
}
