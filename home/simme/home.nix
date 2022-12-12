{ inputs, lib, config, pkgs, ... }: {
  nixpkgs.config.allowUnfreePredicate = (_: true);
  fonts.fontconfig.enable = true;

  home = {
    username = "simme";
    homeDirectory = "/home/simme";
    stateVersion = "22.11";
    packages = with pkgs;
      [
        _1password-gui
        cinnamon.nemo
        ctop
        direnv
        dive
        exa
        git
        gnumake
        gnupg
        grim
        jq
        k6
        kitty
        lynx
        mako
        matterhorn
        mattermost-desktop
        mosh
        neofetch
        obinskit
        obsidian
        pavucontrol
        ripgrep
        skopeo
        slurp
        spotify
        spotify-tui
        sshuttle
        swayidle
        swaylock
        syft
        tdesktop
        tmux
        tree
        unrar
        unzip
        wf-recorder
        wl-clipboard
        yq
        zip
        (nerdfonts.override
          {
            fonts = [
              "FiraCode"
            ];
          })
      ];
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-13.6.9"
  ];
}
