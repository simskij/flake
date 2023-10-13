{
  config,
  pkgs,
  inputs,
  outputs,
  stateVersion,
  username,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./desktop
    ./development
    ./modules
    ./shell
  ];

  nixpkgs.config.allowUnfree = true; 

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = stateVersion;
  };

  home.packages = with pkgs; [
    bc
    spotify
    obs-studio
  ];
}
