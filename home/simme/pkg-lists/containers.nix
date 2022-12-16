{pkgs, ...}: {
  list = with pkgs; [
    ctop
    dive
    skopeo
    syft
  ];
}
