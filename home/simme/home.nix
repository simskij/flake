{ inputs, lib, config, pkgs, ... }: {

  nixpkgs = {
    config = {
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "electron-13.6.9"
      ];
    };
  };

  fonts.fontconfig.enable = true;

  home = {
    username = "simme";
    homeDirectory = "/home/simme";
    stateVersion = "22.11";

    packages = with pkgs; []
      ++ (import ./pkg-lists/containers.nix pkgs).list
      ++ (import ./pkg-lists/desktop.nix pkgs).list 
      ++ (import ./pkg-lists/media.nix pkgs).list
      ++ (import ./pkg-lists/messaging.nix pkgs).list
      ++ (import ./pkg-lists/programming.nix pkgs).list
      ++ (import ./pkg-lists/utils.nix pkgs).list;
    
    file = {
      ".config/neofetch/config.conf" = {
        text = ''
          print_info() {
            info "$(color 2)" distro
            info "$(color 3)" uptime
          }
          distro_shorthand="tiny"
          os_arch="off"
          uptime_shorthand="tiny"
          ascii=""
        '';
      };
    };
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
    mako = {
      enable = true;
      textColor = "#cdd6f4";
      backgroundColor = "#1e1e2e";
      borderColor = "#89b4fa";
      defaultTimeout = 5000;
      progressColor = "#313244";
      extraConfig = ''
        [urgency=high]
        border-color=#fab387
      '';
    };
  };
}
