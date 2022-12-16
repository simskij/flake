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
}
