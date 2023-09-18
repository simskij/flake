{ pkgs, ... }: { 
  environment = {
    variables = {
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      polkit_gnome
    ];
  };

  programs = {
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "simme" ];
    };
    sway = {
      enable = true;
    };
  };

  services = {
    dbus = {
      enable = true;
      packages = [
        pkgs.gnome3.gnome-keyring pkgs.gcr
      ];
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
      gnome-keyring.enable = true;
      at-spi2-core.enable = true;
      sushi.enable = true;
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  }; 

  security = {
    pam = {
      services = {
        greetd.enableGnomeKeyring = true;
      };
    };
  };
}
