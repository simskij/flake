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

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = stateVersion;
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      inputs.hyprland.overlays.default
      inputs.hyprland-contrib.overlays.default
      inputs.crafts.overlay 
      (_self: _super: {
        fcitx-engines = pkgs.fcitx5;
      })
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "electron-13.6.9"
      ];
    };
  };
  home.packages = with pkgs; [
    wlprop
    bc
    hyprprop
    obs-studio
  ];
}
