{
    config,
    system,
    lib,
    pkgs,
    ...
}:
let
    cfg = config.arctic.apps.tailscale;
in
    with lib;
{
    options = {
        arctic.apps.tailscale.enable = mkEnableOption "";
    }; 
    config = mkIf cfg.enable {
        environment = {
            systemPackages = with pkgs; [
                tailscale
            ];
        };
        services = {
            tailscale = {
                enable = true;
            };
        };
        networking = {
            networkmanager = {
                unmanaged = [
                    "tailscale0"
                ];
            };
            firewall = {
                allowedUDPPorts = [
                    config.services.tailscale.port
                ];
                trustedInterfaces = [
                    "tailscale0"
                ];
            };
        };
    };
}
