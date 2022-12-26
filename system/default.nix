{ config, pkgs, lib, secrets, ... }: {

  imports = [
    ./modules/audio
    ./modules/bluetooth
    ./modules/boot
    ./modules/desktop
    ./modules/gpg
    ./modules/kube
    ./modules/locale
    ./modules/networking
    ./modules/pkgs
    ./modules/steam
    ./modules/users
    ./modules/virtualization
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-13.6.9"
      ];
    };
  };

  system = {
    stateVersion = "22.05";
  };

}
