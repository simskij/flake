{ config, pkgs, lib, ... }: {

  services = {
    k3s = {
      enable = true;
      role = "server";
    };
  };

}
