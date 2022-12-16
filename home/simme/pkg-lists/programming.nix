{pkgs, ...}: {
  list = with pkgs; [
    gcc 
    git
    gnumake
    jq
    nodejs
    rustup
    yq
  ];
}
