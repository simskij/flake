{
  inputs,
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
    ./packages
    ./settings
  ];
  
  nixpkgs = {
    overlays = [
     inputs.crafts.overlay
     (final: _: {
       stable = import inputs.nixpkgs-stable {
         system = "x86_64-linux";
         config = {
           allowUnfree = true;
           permittedInsecurePackages = [
             "electron-25.9.0"
           ];
         };
       };
     })
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

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

        nixpkgs.overlays = [
          inputs.crafts.overlay
        ];
        qt = {
          enable = true;
          platformTheme = "gtk";
        };

        programs = {
          btop = {
            enable = true;
            settings = {
              color_theme = "catppuccin";
            };
          };
        };

        services = {
          keybase.enable = true;
        };

        home = {
          username = username;
          homeDirectory = "/home/${username}";
          file = {
            ".config/btop/themes/catppuccin.theme" = {
                text = ''
                  theme[main_bg]="#1e1d2f"
                  theme[main_fg]="#d9e0ee"
                  theme[title]="#d9e0ee"
                  theme[hi_fg]="#96cdfb"
                  theme[selected_bg]="#302d41"
                  theme[selected_fg]="#96cdfb"
                  theme[inactive_fg]="#6e6c7e"
                  theme[graph_text]="#c3bac6"
                  theme[meter_bg]="#575268"
                  theme[proc_misc]="#C3BAC6"
                  theme[cpu_box]="#89dceb"
                  theme[mem_box]="#abe9b3"
                  theme[net_box]="#ddb6f2"
                  theme[proc_box]="#96cdfb"
                  theme[div_line]="#575268"
                  theme[temp_start]="#fae3b0"
                  theme[temp_mid]="#f8bd95"
                  theme[temp_end]="#e8a2af"
                  theme[cpu_start]="#89dceb"
                  theme[cpu_mid]="#89dceb"
                  theme[cpu_end]="#96cdfb"
                  theme[free_start]="#b5e8e0"
                  theme[free_mid]="#abe9b3"
                  theme[free_end]="#abe9b3"
                  theme[cached_start]="#c9cbff"
                  theme[cached_mid]="#ddb6f2"
                  theme[cached_end]="#ddb6f2"
                  theme[available_start]="#f5e0dc"
                  theme[available_mid]="#f2cdcd"
                  theme[available_end]="#f2cdcd"
                  theme[used_start]="#f8bd96"
                  theme[used_mid]="#f8bd96"
                  theme[used_end]="#e8a2af"
                  theme[download_start]="#c9cbff"
                  theme[download_mid]="#c9cbff"
                  theme[download_end]="#ddb6f2"
                  theme[upload_start]="#c9cbff"
                  theme[upload_mid]="#c9cbff"
                  theme[upload_end]="#ddb6f2"
                  theme[process_start]="#96cdfb"
                  theme[process_mid]="#96cdfb"
                  theme[process_end]="#89dceb"
                '';
            };
          };

          packages = with pkgs; [
            (catppuccin-kvantum.override {
              variant = "Macchiato";
              accent = "Blue";
            })
            charmcraft
            snapcraft
            multipass
            juju
            appimage-run
            blueberry
            cinnamon.nemo
            direnv
            flameshot
            grim
            keybase-gui
            kbfs
            libnotify
            libsForQt5.qtstyleplugin-kvantum
            lutris
            lynx
            matterhorn
            mudlet
            stable.obsidian
            stable.mattermost-desktop
            rambox
            slurp
            spotify
            swayidle
            swaylock
            tdesktop
            tmux
            ubuntu_font_family
            udev
            usbutils
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
