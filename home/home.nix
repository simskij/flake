{ pkgs, config, libs, ... }:

with import <nixpkgs> {};
with lib;

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";
in {
  imports = [
    (import "${home-manager}/nixos")
  ];
    fonts.fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [ 
          "FiraCode"
        ];
      })
    ];

  users.users.simme = {
    isNormalUser = true;
    description = "simme";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "lxd"
      "video"
      "docker"
    ];
  };

  home-manager.users.simme = {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
      "electron-13.6.9"
    ];

    imports = [
      ./programs/nvim.nix
      ./programs/zsh.nix
    ];

    home.file = {
      ".config/sway/config" = {
        text = ''
          exec dbus-update-activation-environment --systemd \
            DISPLAY \
            WAYLAND_DISPLAY \
            SWAYSOCK \
            XDG_CURRENT_DESKTOP
                    
          exec GDK_BACKEND=wayland ulauncher --hide-window
          
          set $menu ulauncher-toggle
          set $term kitty
          set $mod mod4
          
          
          floating_modifier $mod normal
          
          bindsym {
            $mod+space exec $menu
            $mod+return exec $term
            $mod+Shift+c reload
            $mod+Shift+q kill
            $mod+Left focus left
            $mod+Down focus down
            $mod+Up focus up
            $mod+Right focus right
            $mod+Shift+Left move left
            $mod+Shift+Down move down
            $mod+Shift+Up move up
            $mod+Shift+Right move right
            $mod+1 workspace 1
            $mod+2 workspace 2
            $mod+3 workspace 3
            $mod+4 workspace 4
            $mod+5 workspace 5
            $mod+6 workspace 6
            $mod+7 workspace 7
            $mod+8 workspace 8
            $mod+9 workspace 9
            $mod+0 workspace 10
            $mod+Shift+1 move container to workspace 1
            $mod+Shift+2 move container to workspace 2
            $mod+Shift+3 move container to workspace 3
            $mod+Shift+4 move container to workspace 4
            $mod+Shift+5 move container to workspace 5
            $mod+Shift+6 move container to workspace 6
            $mod+Shift+7 move container to workspace 7
            $mod+Shift+8 move container to workspace 8
            $mod+Shift+9 move container to workspace 9
            $mod+Shift+0 move container to workspace 10
            # Layout
            $mod+b splith
            $mod+v splitv
            $mod+s layout stacking
            $mod+w layout tabbed
            $mod+e layout toggle split
            $mod+f fullscreen
            $mod+Shift+space floating toggle
            $mod+Shift+f focus mode_toggle
            $mod+a focus parent
          }
          
          gaps outer 5
          gaps inner 30
          
          default_border none 0
          
          for_window {
              [app_id="ulauncher"] floating enable, border none
          }
          
          input "type:keyboard" {
            xkb_layout us
            xkb_variant mac
          }
          
          output * bg /home/simme/.wallpaper.png fill
          output * scale 1
          
          output HDMI-A-1 mode 3440x1440 pos 0 0
          output DP-4 transform 90 pos 3440 0
          
          bindsym $mod+Shift+e exec swaynag \
            -t warning \
            -m 'Really?' \
            -B 'Yes, exit sway' 'swaymsg exit'
        '';
      };
    };

    home.packages = with pkgs; [
      _1password-gui
      ctop
      dive
      exa
      git
      gnupg
      jq
      k6
      obinskit
      kitty
      lynx
      matterhorn
      mattermost-desktop
      mosh
      cinnamon.nemo
      gnumake
      neofetch
      obsidian
      pavucontrol
      unstable.rambox
      ripgrep
      sshuttle
      skopeo
      spotify
      spotify-tui
      syft
      tdesktop
      tmux
      tree
      unstable.slack
      unzip
      unrar
      yq
      zip
    ];
    programs = {
      starship.enable = true;
      chromium = {
        enable = true;
    extensions = [
      "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "ldgfbffkinooeloadekpmfoklnobpien" # raindrop
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      "kbfnbcaeplbcioakkpcpgfkobkghlhen" # grammarly 
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
    ];
      };
      vscode = {
        enable = true;
    package = pkgs.vscodium;
        extensions = with vscode-extensions; [
      esbenp.prettier-vscode
      golang.go
      bierner.emojisense
    ] ++ vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "catppuccin-vsc";
            publisher = "Catppuccin";
            version = "2.3.0";
            sha256 = "5S6XrdAJwnsy7JO62e4yvcKDJhOjxbnqaQbQuXlrZE0=";
      }
    ];
      };
      waybar = {
        enable = true;
    systemd.enable = true;
    settings = [{
      height = 40;
      layer = "top";
      position = "bottom";
      tray = { spacing = 10; };
      modules-left = [
        "sway/workspaces" 
        "sway/mode" 
        "sway/window" 
      ];
      modules-right = [ 
#        "cpu"
#        "memory"
#        "pulseaudio"
        "tray" 
        "clock" 
      ]; 
    }];
      };
    };
  };
}
