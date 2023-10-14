{
  config,
  lib,
  pkgs,
  username,
  stateVersion,
  ...
}:
{
  imports = [
    ./apps
    ./base
    ./desktop
    ./network
    ./settings
  ];

  users.users = {
    "${username}" = {
      initialPassword = "ChangeMe!";
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
        "networkmanager"
        "audio"
        "video"
      ];
    };
  };

  home-manager = {
    users = {
      "${username}" = {

        qt = {
          enable = true;
          platformTheme = "gtk";
        };
        nixpkgs = {
          config = {
            allowUnfree = config.arctic.settings.unfree;
          };
        };
        home = {
          username = username;
          homeDirectory = "/home/${username}";

          packages = with pkgs; [
            (catppuccin-kvantum.override {
              variant = "Macchiato";
              accent = "Blue";
            })
            
            libsForQt5.qtstyleplugin-kvantum
            appimage-run
            blueberry
            cinnamon.nemo
            discord
            flameshot
            grim
            lutris
            mattermost-desktop
            mudlet
            obsidian
            rambox
            slurp
            spotify
            swayidle
            swaylock
            tdesktop
            ubuntu_font_family
            udev
            v4l-utils
            via
            wdisplays
            wf-recorder
            wl-clipboard
            wlsunset
            xdg-utils
          ];

          sessionVariables = {
            _JAVA_AWT_WM_NONREPARENTING = "1";
            CLUTTER_BACKEND = "wayland";
            GDK_BACKEND = "wayland";
            MOZ_ENABLE_WAYLAND = "1";
            QT_QPA_PLATFORM = "wayland";
            QT_STYLE_OVERRIDE = "kvantum";
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            SDL_VIDEODRIVER = "wayland";
            XDG_SESSION_TYPE = "wayland";
          };

          pointerCursor = {
            package = pkgs.gnome.adwaita-icon-theme;
            name = "Adwaita";
            size = 24;
            gtk.enable = true;
            x11.enable = true;
          };

          stateVersion = stateVersion;
        };
      };
    };
  };
  
  environment.systemPackages = with pkgs; [ 
    git
    pciutils
    python3
    ulauncher
    usbutils
  ];
}
