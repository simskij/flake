{
    config,
    lib,
    username,
    ...
}:
let
  cfg = config.arctic.apps.lxd;
in
  with lib;
{
  options = {
    arctic.apps.lxd.enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
      };
      lxd = {
        enable = true;
        recommendedSysctlSettings = true;
      };
    };
    networking = {
      firewall = {
        trustedInterfaces = [ "lxdbr0" ];
      };
    };
    users.users."${username}".extraGroups = [
      "lxd"
    ];
  };
}
