{ inputs, lib, config, pkgs, ... }: {

  imports = [
    ./modules
  ];

  nixpkgs = {
    config = {
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "electron-13.6.9"
      ];
    };
  };

  fonts.fontconfig.enable = true;

  home = {
    username = "simme";
    homeDirectory = "/home/simme";
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;
}
