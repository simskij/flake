{pkgs, ...}: {
  list = with pkgs; [
    pavucontrol
    spotify
    spotify-tui
    spicetify-cli
  ];
}
