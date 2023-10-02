{ config, ... }: {
  networking = {
    networkmanager = {
      enable = true;
      unmanaged = [
        "tailscale0"
        "lxdbr0"
      ];
    };

    firewall = {
      checkReversePath = "loose";
      enable = true;
      allowedUDPPorts = [
        config.services.tailscale.port
      ];
      allowedTCPPorts = [
        22
        6443
        8443
      ];
      trustedInterfaces = [
        "tailscale0"
        "lxdbr0"
      ];
    };
  };

  programs = { 
    mtr = {
      enable = true;
    };
  };

  services = {
    openssh = {
      enable = true;
    };
    tailscale = {
      enable = true;
    };
  };

}
