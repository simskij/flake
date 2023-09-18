{ pkgs, lib, username, ... }: {
  home.packages = with pkgs; [
    eww-wayland
    socat
    wlr-randr
  ];

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./config;
  };
}
