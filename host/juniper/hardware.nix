{
  inputs,
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
  '';

  hardware = {
    cpu.amd.updateMicrocode = true;
    opengl.enable = true;
  };
}
