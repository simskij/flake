{ pkgs, ... } : let on = { enable = true; }; in
{
  arctic = { 
    settings = {
      audio = true;
      unfree = true;
      timezone = "Europe/Stockholm";
      recycle-after-days = 3;
      nerd-fonts = [
        "FiraCode"
        "DroidSansMono"
      ];
    };
    
    home-manager = {
      extraSpecialArgs = {
        inherit inputs outputs stateVersion username;
      };
    };
    
    desktop = on // {
      keyboard = {
        layout = "us";
        variant = "mac";
      };
      addons = {
        waybar    = on;
        mako      = on;
      };
    };

    apps = {
      fileutils   = on;
      gpg         = on;
      lxd         = on;
      netutils    = on;
      onepassword = on;
      steam       = on;
      tailscale   = on;
      zip         = on;
      nvim = on // {
        settings = {
          tab-width = 2;
          numbers = true;
        };
        plugins = {
          devicons = on;
          easy-align = on;
          gitgutter = on;
          mason = on;
          telescope = on;
          terminal = on;
          tree = on;
        };
      };
      chromium    = on // {
        extensions = [
          "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
          "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
          "ldgfbffkinooeloadekpmfoklnobpien" # raindrop
          "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
          "kbfnbcaeplbcioakkpcpgfkobkghlhen" # grammarly 
          "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
        ];
      };
      kitty = on // {
        font = "FiraCode Nerd Font";
        shell = pkgs.zsh;
        theme = "Catppuccin-Mocha";
        padding = 18;
      };
      zsh = on // {
        dots = ".config/zsh";
        aliases = {
          auth           = "ssh-add ~/.ssh/id_rsa";
          ll             = "ls -la";
          reload         = "echo \"usage: reload.[nixos|shell]\"";
          "reload.nixos" = "sudo nixos-rebuild switch --flake ~/code/simskij/nixos-config";
          "reload.shell" = "source ~/.zshrc";
        };
        addons = {
          starship = on;
        };
      };
    };
    
    network = {
      ssh = on // {
        addons = {
          sshuttle = on;
          mosh = on;
        };
        keys = [(
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDI4GSYHKigC9SvhQGUZUtP2yU+T84fpvyDB5T" +
          "0xlU19b67rbImzmVk/U8wpn5syc9P918f4RWRYvo2DUai7EyZ3pB2RIdB7QM+FNMVZZg64CAUjs" +
          "80oTQdJUd8I8H/x7vXMZS9MyOnYEpUf0Jp3JYfzd7O6SqeaBtugNZEQxrhTHVQQZu/tzHVjynib" +
          "W94JoWXfKP28DBCaWWnRutT/kO457b+Rn7ld7/fDzJwipwmrj0ZdDcHO+vebbHfqNX588jNvR2A" +
          "XUNlauc6uI+R7Bv8OvVUKnhsSmlCjhacLyHboYppQCyY7+FkukH0VrF3YV8X49DRczswm/k83vm" +
          "h+GMF"
        )];
      };
      firewall = on;
      dns = [
        "10.0.0.1"
        "1.1.1.1"
      ];
    };
    packages = with pkgs;
    [
      jetbrains.goland
      jetbrains.pycharm-professional
      jetbrains.webstorm
    ] ++
    [
      (catppuccin-kvantum.override {
        variant = "Macchiato";
        accent = "Blue";
      })
      appimage-run
      blueberry
      cinnamon.nemo
      ctop
      discord
      dive
      flameshot
      gcc 
      git
      gnumake
      go
      grim
      k6
      kubectl
      libsForQt5.qtstyleplugin-kvantum
      lutris
      mattermost-desktop
      mudlet
      nodejs
      obsidian
      rambox
      rustup
      skopeo
      slurp
      spotify
      swayidle
      swaylock
      syft
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
  };
}
