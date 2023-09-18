{ pkgs, spicetify-nix, lib, config, ... }:

let spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in {

  imports = [
    ./sway
    ./eww
    ./hyprland
    ./waybar
    ./mako 
    spicetify-nix.homeManagerModule
  ];

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit.Description = "polkit-gnome-authentication-agent-1";
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  home = {
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
    packages = with pkgs; [
      (catppuccin-kvantum.override { variant = "Macchiato"; accent = "Blue"; })
      libsForQt5.qtstyleplugin-kvantum
      fira-mono-nerd
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
      pavucontrol
      playerctl
      rambox
      slurp
      swayidle
      swaylock
      tdesktop
      ubuntu_font_family
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
    pointerCursor = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };

  programs = {
    spicetify = {
      enable = true;
      theme = spicePkgs.themes.catppuccin-macchiato;
      colorScheme = "flamingo";
      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle
        hidePodcasts
      ];
    };
  };

  xdg = {
    enable = true;
    

    configFile = {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=Catppuccin-Macchiato-Blue
      '';
    };

    configHome = config.home.homeDirectory + "/.config";
    cacheHome = config.home.homeDirectory + "/.local/cache";
    dataHome = config.home.homeDirectory + "/.local/share";
    stateHome = config.home.homeDirectory + "/.local/state";

    userDirs = {
      enable = true;
      createDirectories = lib.mkDefault true;

      download = config.home.homeDirectory + "/downloads";
      pictures = config.home.homeDirectory + "/pictures";

      desktop = config.home.homeDirectory;
      documents = config.home.homeDirectory;
      music = config.home.homeDirectory;
      publicShare = config.home.homeDirectory;
      templates = config.home.homeDirectory;
      videos = config.home.homeDirectory;

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/pictures/screenshots";
      };
    };
  };

  gtk = {
    enable = true;
    font.name = "Ubuntu Mono";
    theme = {
      name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "macchiato";
      };
    };
  };

  
}
