{pkgs, ...}: {
  
  home = {
    packages = with pkgs; [
      neofetch
    ];
  };
  
  home = {
    file = {
      ".config/neofetch/config.conf" = {
        text = ''
          print_info() {
            info "$(color 2)  " kernel
            info "$(color 2)  " distro
            info "$(color 2)  " shell
            info "$(color 2)  " term
            info "$(color 2)  " wm
            prin
            info "$(color 3)  " uptime
          }
          distro_shorthand="tiny"
          os_arch="off"
          uptime_shorthand="tiny"
          ascii=""
          ascii_distro="nixos_small"
          image_backend="kitty"
          image_size="180px"
          image_source="/home/simme/.distro.png"
        '';
      };
    };
  };
}
