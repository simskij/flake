{ config, pkgs, lib, ... }:

{
  virtualisation = {
    containerd.enable = true;
    docker.enable = true;
    libvirtd.enable = true;
    lxd.enable = true;
  };
}
