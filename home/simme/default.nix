{
  config,
  pkgs,
  outputs,
  stateVersion,
  username,
  ...
}: {
  imports = [
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

}
