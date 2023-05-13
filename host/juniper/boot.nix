{ ... }: {
  boot = {
    initrd = {
      kernelModules = [];
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
}