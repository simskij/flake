{ config, pkgs, lib, ... }: {
 
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  programs = {
    sway = {
      enable = true;
    };
  };

  services = {
    dbus.enable = true;
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
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };
  
}
