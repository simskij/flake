{ config, pkgs, lib, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-13.6.9"
      ];
    };
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      autoconf
      automake
      dpkg
      dracula-theme
      firecracker
      ignite
      libxfs
      git
      glib
      gnome3.adwaita-icon-theme
      go_1_18
      psmisc
      python3
      qemu
      tailscale
      ulauncher
      unzip
      vim
      wayland
      wget
      xdg-utils
    ];
  };

  services = {
    tailscale.enable = true;
    openssh.enable = true;
    dbus.enable = true;
    k3s = {
      enable = true;
      role = "server";
    };
    xserver = {
      layout = "us";
      xkbVariant = "mac";
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

  programs = {
    mtr.enable = true;
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    sway = {
      enable = true;
    };
  };

  system.stateVersion = "22.05";
}
