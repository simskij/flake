{ pkgs, ... }: { 
  environment = {
    variables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  programs = {
    sway = {
      enable = true;
    };
  };

  services = {
    dbus = {
      enable = true;
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
    gnome = {
      at-spi2-core.enable = true;
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
