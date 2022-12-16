{pkgs, ...}: {
  list = with pkgs; [
    (callPackage ../../../../pkgs/rambox.nix { })
    matterhorn
    mattermost-desktop
    tdesktop
  ];
}
