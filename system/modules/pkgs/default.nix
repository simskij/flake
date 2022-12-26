{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      autoconf
      automake
      dpkg
      dracula-theme
      firecracker
      ignite
      libxfs
      git
      glib
      gnome3.adwaita-icon-theme
      go_1_18
      psmisc
      python3
      qemu
      tailscale
      ulauncher
      unzip
      vim
      wayland
      wget
      xdg-utils
    ];
  };
}
