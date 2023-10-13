{
  stateVersion,
  hostname,
  ...
}:
{

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  system.stateVersion = stateVersion;
}
