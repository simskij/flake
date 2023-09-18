{
  inputs,
  pkgs,
  ...
}: {

  imports = [
    inputs.disko.nixosModules.disko
    (import ./disks.nix { })
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="04d9", ATTRS{idProduct}=="8008", MODE="0666", GROUP="wheel"
    KERNEL=="hidraw*", ATTRS{idVendor}=="04d9", ATTRS{idProduct}=="8008", MODE="0666", GROUP="wheel"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="3434". ATTRS{idProduct}=="0181", MODE="0666", GROUP="wheel"
  '';

  environment.systemPackages = with pkgs; [
    qmk
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    opengl.enable = true;
    keyboard = {
      qmk.enable = true;
      zsa.enable = true;
    };
  };
}
