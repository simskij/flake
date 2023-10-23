{
  config,
  lib,
  pkgs,
  username,
  inputs,
  system,
  ...
}:
let
  cfg  = config.arctic.settings;
  days = config.arctic.settings.recycle-after-days;
  nf   = config.arctic.settings.nerd-fonts;
in
  with lib;
{
  options = {
    arctic = {
      settings = {
        timezone = mkOption { type = types.str; };
        audio = mkEnableOption "";
        unfree = mkOption { type = types.bool; };
        recycle-after-days = mkOption {
          type = types.int;
          default = 7;
        };
        nerd-fonts = mkOption {
          type = types.listOf types.str;
          default = [];
        };
      };
    };
  };

  config = {
    security = {
      polkit.enable = true;
      rtkit.enable = true;
    };

    home-manager = {
      users = {
        "${username}" = {
          systemd.user.services.polkit-gnome-authentication-agent-1 = {
            Unit.Description = "polkit-gnome-authentication-agent-1";
            Install.WantedBy = [ "graphical-session.target" ];
            Service = {
              Type = "simple";
              ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
              Restart = "on-failure";
              RestartSec = 1;
              TimeoutStopSec = 10;
            };
          };
        };
      };
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

    time = {
      timeZone = cfg.timezone;
    };

    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than ${toString days}d";
      };
      optimise = {
        automatic = true;
      };
      settings = {
        auto-optimise-store = true;
      };
    };


    fonts = {
      fontconfig.enable = true;
      packages =
        with pkgs;
        mkIf (lib.lists.count (a: true) nf > 0) [
          (nerdfonts.override { fonts = nf; })
        ];
    };

    services.pipewire = mkIf cfg.audio {
      enable = true;
        alsa.enable = true;
        pulse.enable = true;
      };

    environment.systemPackages =
      with pkgs;
      mkIf cfg.audio [
        pavucontrol
        playerctl
      ];
  };
}
