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
            prin

            info "" distro
            prin
            info "⦠ $(color 3)   " kernel
            info "⦠ $(color 3)   " shell
            info "⦠ $(color 3)   " term
            info "⦠ $(color 3)   " de
            info "⦠ $(color 3)   " uptime

            prin

            info "" model

            prin 
            info "⦠ $(color 2)   " cpu
            info "⦠ $(color 2) 󰍛  " memory
            info "⦠ $(color 2)   " gpu
            info "⦠ $(color 2)   " resolution

          }
          os_arch="off"
          uptime_shorthand="tiny"
          separator="  "
          ascii=""
          kernel_shorthand="off"
          ascii_distro="nixos_small"
          image_backend="kitty"
          image_size="290px"
          image_source="/home/simme/.distro.png"
        '';
      };
    };
  };
}
