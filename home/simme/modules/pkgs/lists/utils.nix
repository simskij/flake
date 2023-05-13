
{pkgs, ...}: {
  list = with pkgs; [
    _1password-gui
    appimage-run
    bat
    direnv
    discord
    exa
    gnupg
    k6
    libnotify
    lynx
    mosh
    mudlet
    obsidian
    quickemu
    ranger
    ripgrep
    sshuttle
    tmux
    tree
    ubuntu_font_family
    unrar
    unzip
    usbutils
    wlsunset
    xdg-utils
    zip
  ];
}
