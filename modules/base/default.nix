{
  stateVersion,
  hostname,
  config,
  pkgs,
  lib,
  ...
}:
  with lib;
{

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  system = {
    stateVersion = mkIf (!hasSuffix "-darwin" config.nixpkgs.hostPlatform.system) stateVersion;
  };
}
