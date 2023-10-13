{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.arctic.desktop;
  on = { enable = true; };
in
  with lib;
{
  options.arctic.desktop = {
    enable = mkEnableOption "";
    keyboard = {
      layout  = mkOption { type = types.string; default = "us";  };
      variant = mkOption { type = types.string; default = "mac"; };
    };
  };

  config = mkIf cfg.enable {

    services = {
      greetd = {
        enable = true;
        restart = false;
        settings = {
          default_session = {
            command = ''
              ${lib.makeBinPath [pkgs.greetd.tuigreet]}/tuigreet -r --asterisks --time \
                  --cmd ${pkgs.hyprland}/bin/Hyprland 
            '';
          };
        };
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

    environment = {
      variables = {
        NIXOS_OZONE_WL = "1";
      };
      systemPackages = with pkgs; [
        polkit_gnome
        wayland
      ];
    };

    services = {
      dbus = on // {
        packages = with pkgs; [
          gnome3.gnome-keyring
          gcr
        ];
      };
      xserver = {
        layout = cfg.keyboard.layout;
        xkbVariant = cfg.keyboard.variant;
        displayManager = {
          gdm = on // { wayland = true; };
        };
      };
      gnome = {
        gnome-keyring = on;
        at-spi2-core = on; 
        sushi = on;
      };
    };

    security = {
      pam = {
        services = {
          greetd = {
            enableGnomeKeyring = true;
          };
        };
      };
    };
  };
}
