{ config, pkgs, lib, ... }:

{
  users.users = {
    simme = {
      initialPassword = "ChangeMe!";
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
        "networkmanager"
        "audio"
        "video"
      ];
    };
  };
}
