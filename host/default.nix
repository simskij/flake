{
  config,
  hostname,
  inputs,
  lib, 
  modulesPath,
  outputs,
  stateVersion,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./common/default.nix
    (./. + "/${hostname}/boot.nix")
    (./. + "/${hostname}/hardware.nix")
  ]
    ++ lib.optional (builtins.pathExists (./. + "/${hostname}/extra.nix"))   ./${hostname}/extra.nix
    ++ lib.optional (builtins.pathExists (./. + "/${hostname}/desktop.nix")) ./${hostname}/desktop.nix;

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  services = {
    #vscode-server = {
    #  enable = true;
    #};
  };

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    
    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  system.stateVersion = stateVersion;
}
