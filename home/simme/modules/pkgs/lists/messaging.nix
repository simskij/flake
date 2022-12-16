{pkgs, ...}: {
  list = with pkgs; [
    matterhorn
    mattermost-desktop
    tdesktop
  ];
}
