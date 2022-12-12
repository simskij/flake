{ config, pkgs, lib, ... }:

{
  boot = {
    extraModprobeConfig = "options kvm_amd nested=1";
    kernelModules = [ "vhost_vsock" ];
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };
}
