{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    steam-tui
    steamcmd
  ];

  programs = {
    steam = {
      enable = true;
      remotePlay = {
        openFirewall = true;
      };
      dedicatedServer = {
        openFirewall = true;
      };
    };
  };
}
