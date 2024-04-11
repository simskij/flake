{ pkgs, lib, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd = {
      kernelModules = [
        "amdgpu"
	"vfat"
	"nls_cp437"
	"nls_iso8859-1"
	"usbhid"
      ];
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      luks = {
        yubikeySupport = true;
	devices = {
	  "nixos-enc" = {
	    device = "/dev/nvme1n1p2";
	    preLVM = true;
	    yubikey = {
	      slot = 2;
	      twoFactor = true;
	      storage = {
	        device = "/dev/nvme1n1p1";
	      };
	    };
	  };
	};
      };
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
  systemd.services.NetworkManager-wait-online = {
    serviceConfig = {
      ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
    };
  };
}
