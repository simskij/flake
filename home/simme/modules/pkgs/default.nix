{ pkgs, ...}: {
  
  home = {
    packages = []
      ++ (import ./containers.nix pkgs).list
      ++ (import ./desktop.nix pkgs).list
      ++ (import ./media.nix pkgs).list
      ++ (import ./messaging.nix pkgs).list
      ++ (import ./programming.nix pkgs).list
      ++ (import ./utils.nix pkgs).list;
  };
}
