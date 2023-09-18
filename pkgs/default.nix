{ pkgs, ... }: {
  fira-mono-nerd = pkgs.callPackage ./fira-mono.nix { };
  rambox = pkgs.callPackage ./rambox.nix { };
}
