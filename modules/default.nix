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
    ./homebrew
    ./network
    ./packages
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
