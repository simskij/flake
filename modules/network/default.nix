{
    config,
    lib,
    username,
    hostid,
    hostname,
    ...
}:
let
    cfg = config.arctic.network;
in
    with lib;
{
    options = {
        arctic = {
            network = {
                ssh = {
                    enable = mkEnableOption "";
                    keys = mkOption { type = types.listOf types.str; default = []; };
                };
                dns = mkOption { type = types.listOf types.str; default = [ "1.1.1.1" ]; };
                firewall = {
                    enable = mkEnableOption "";
                    allowed-ports = {
                        tcp = mkOption { type = types.listOf types.int; default = []; };
                        udp = mkOption { type = types.listOf types.int; default = []; };
                    };
                };
            };
        };
    };

    config = {
        networking = {
            hostId = hostid;
            hostName = hostname;
        };
        networking = {
          networkmanager = {
            enable = true;
            unmanaged = ([]
              ++ (if config.arctic.apps.lxd.enable       then ["lxdbr0"    ] else [])
              ++ (if config.arctic.apps.tailscale.enable then ["tailscale0"] else []));
          };
          firewall = mkIf cfg.firewall.enable {
            checkReversePath = "loose";
            enable = true;
            allowedTCPPorts = cfg.firewall.allowed-ports.tcp
              ++ (if cfg.ssh.enable then [22] else []);
            allowedUDPPorts = cfg.firewall.allowed-ports.udp;
          };
          nameservers = cfg.dns;
        };
        services = {
            openssh = {
                enable = cfg.ssh.enable;
                settings = {
                  PasswordAuthentication = false;
                  KbdInteractiveAuthentication = false;
                  PermitRootLogin = "no";
                };
            };
        };
        users = {
            users = {
                "${username}" = {
                    openssh = {
                        authorizedKeys = {
                            keys = cfg.ssh.keys;
                        };
                    };
                };
            };
        };
    };
}

