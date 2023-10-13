{
    config,
    lib,
    pkgs,
    ...
}:
let
    cfg = config.arctic.apps.netutils;
in
    with lib;
{
    options.arctic.apps.netutils.enable = mkEnableOption "";
    config = mkIf cfg.enable {
        programs.mtr.enable = true;
        environment.systemPackages = with pkgs; [
            curl
            dig
            sshuttle
            ngrok
            traceroute
            wget
        ];
    };
}
