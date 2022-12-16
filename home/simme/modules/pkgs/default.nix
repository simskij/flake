{ pkgs, ...}: {
  
  home = {
    packages = []
      ++ (import ./lists/containers.nix pkgs).list
      ++ (import ./lists/desktop.nix pkgs).list
      ++ (import ./lists/media.nix pkgs).list
      ++ (import ./lists/messaging.nix pkgs).list
      ++ (import ./lists/programming.nix pkgs).list
      ++ (import ./lists/utils.nix pkgs).list;
  };
}
