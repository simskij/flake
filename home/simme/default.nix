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
    ./browser
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
    wlprop
    bc
    spotify
    obs-studio
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}
