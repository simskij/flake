{
    config,
    lib,
    pkgs,
    ...
}:
let
    cfg = config.arctic.apps.steam;
in
    with lib;
{
    options = {
        arctic.apps.steam.enable = mkEnableOption "";
    };

    config = mkIf cfg.enable {
        programs = {
            steam = {
                enable = true;
                remotePlay.openFirewall = true;
                dedicatedServer.openFirewall = true;
            };
        };
    };
}
