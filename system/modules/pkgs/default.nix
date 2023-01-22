{ pkgs, ... }: {
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="04d9", ATTRS{idProduct}=="8008", MODE="0666", GROUP="wheel"
    KERNEL=="hidraw*", ATTRS{idVendor}=="04d9", ATTRS{idProduct}=="8008", MODE="0666", GROUP="wheel"
  '';
  environment = {
    systemPackages = with pkgs; [
      autoconf
      automake
      dpkg
      dracula-theme
      firecracker
      home-manager
      ignite
      libxfs
      git
      glib
      gnome3.adwaita-icon-theme
      go_1_18
      obinskit
      psmisc
      python3
      qemu
      tailscale
      ulauncher
      unzip
      vim
      wayland
      wineWowPackages.stable
      winetricks
      wineWowPackages.waylandFull
      wget
      xdg-utils
    ];
  };
}
