{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_6_2;
    initrd = {
      kernelModules = [
        "amdgpu"
      ];
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = [
      "kvm-amd"
      "vhost_vsock"
    ];
    extraModulePackages = [ ];
    extraModprobeConfig = "options kvm_amd nested=1";
  };

  programs = {
    corectrl = {
      enable = true;
      gpuOverclock = {
        enable = true;
        ppfeaturemask = "0xffffffff";
      };
    };
  };
}
