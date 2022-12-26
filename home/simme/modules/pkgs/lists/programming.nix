{pkgs, ...}: {
  list = with pkgs; [
    gcc 
    git
    gnumake
    jetbrains.goland
    jetbrains.pycharm-professional
    jetbrains.webstorm
    jq
    nodejs
    rustup
    yq
  ];
}
