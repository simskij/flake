{ inputs, lib, config, pkgs, ... }: {
  nixpkgs.config.allowUnfreePredicate = (_: true);
  nixpkgs.overlays = [
    (import ../../overlays/rambox.nix)
  ];
  fonts.fontconfig.enable = true;

  home = {
    username = "simme";
    homeDirectory = "/home/simme";
    stateVersion = "22.11";
    packages = with pkgs;
      [
        _1password-gui
        afetch
        appimage-run
        blueberry
        cinnamon.nemo
        ctop
        direnv
        dive
        exa
        flameshot
        gcc
        git
        gnumake
        gnupg
        grim
        jq
        k6
        kitty
        libnotify
        lynx
        matterhorn
        mattermost-desktop
        mosh
        neofetch
        obinskit
        obsidian
        pavucontrol
        playerctl
        (callPackage ../../pkgs/rambox.nix { })
        ripgrep
        rustup
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
        wayfire
        wdisplays
        wcm
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

  home.file = {
    ".config/neofetch/config.conf" = {
      text = ''
        print_info() {
          info "$(color 2)" distro
          info "$(color 3)" uptime
        }
        distro_shorthand="tiny"
        os_arch="off"
        uptime_shorthand="tiny"
        ascii=""
      '';
    };
  };

  programs.mako = {
    enable = true;
    textColor = "#cdd6f4";
    backgroundColor = "#1e1e2e";
    borderColor = "#89b4fa";
    defaultTimeout = 5000;
    progressColor = "#313244";
    extraConfig = ''
      [urgency=high]
      border-color=#fab387
    '';
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-13.6.9"
  ];
}
