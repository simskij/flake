{ config, pkgs, lib, ... }:

{

  imports = [
    ./modules/bluetooth
    ./modules/boot
    ./modules/locale
    ./modules/networking
    ./modules/pkgs
    ./modules/steam
    ./modules/users
    ./modules/virtualization
  ];

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
