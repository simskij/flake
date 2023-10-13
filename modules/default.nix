{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./apps/1password
    ./apps/chromium
    ./apps/gpg
    ./apps/lxd
    ./apps/steam
    ./apps/tailscale
    ./apps/netutils
    ./apps/zip
    ./apps/zsh
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
  
  environment.systemPackages = with pkgs; [ 
    bat
    binutils
    eza
    file
    git
    htop
    jq
    pciutils
    python3
    ripgrep
    rsync
    tree
    ulauncher
    usbutils
    yq
  ];


  programs = {
    zsh.enable = true;
  };
}
