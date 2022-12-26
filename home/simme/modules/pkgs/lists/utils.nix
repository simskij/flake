{pkgs, ...}: {
  list = with pkgs; [
    _1password-gui
    appimage-run
    direnv
    exa
    gnupg
    k6
    libnotify
    lynx
    mosh
    mudlet
    obinskit
    obsidian
    quickemu
    ranger
    ripgrep
    sshuttle
    tmux
    tree
    unrar
    unzip
    zip
  ];
}
