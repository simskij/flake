{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.arctic.apps.fileutils;
in
  with lib;
{
  options.arctic.apps.fileutils.enable = mkEnableOption "";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
       bat
       binutils
       eza
       ranger
       ripgrep
       rsync
       tree
       file
    ];
  };
}
