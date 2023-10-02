{
  hostname,
  hostid,
  pkgs,
  lib,
  username,
  ...
}: {

  imports = [
    ./audio
    ./bluetooth
    ./desktop
    ./gpg
    ./networking
    ./steam
    ./users/${username}
    ./virtualization
  ];

  networking = {
    hostId = hostid;
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };
  
  environment.systemPackages = with pkgs; [ 
    bat
    binutils
    curl
    dig
    eza
    file
    git
    home-manager
    htop
    jq
    pciutils
    python3
    ripgrep
    rsync
    tailscale
    traceroute
    tree
    ulauncher
    unzip
    usbutils
    wayland
    wget
    yq
    zip
  ];

  time.timeZone = "Europe/Stockholm";

  programs = {
    zsh.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  i18n = {
    defaultLocale = "en_US.utf8";
    extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.utf8";
      LC_IDENTIFICATION = "sv_SE.utf8";
      LC_MEASUREMENT = "sv_SE.utf8";
      LC_MONETARY = "sv_SE.utf8";
      LC_NAME = "sv_SE.utf8";
      LC_NUMERIC = "sv_SE.utf8";
      LC_PAPER = "sv_SE.utf8";
      LC_TELEPHONE = "sv_SE.utf8";
      LC_TIME = "sv_SE.utf8";
    };
  };

  services = {
    greetd = {
      enable = true;
      restart = false;
      settings = {
        default_session = {
          command = ''
            ${lib.makeBinPath [pkgs.greetd.tuigreet]}/tuigreet -r --asterisks --time \
                --cmd /home/simme/.nix-profile/bin/sway 
          '';
        };
      };
    };
  };
}
