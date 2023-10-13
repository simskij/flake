{ inputs, pkgs, ...}: {
  imports = [
    ./javascript
    ./golang
    ./python
    ./rust
  ];
 
  programs = {
    gh = {
      enable = true;
      gitCredentialHelper = {
          enable = true;
      };
      extensions = [
        pkgs.gh-dash
      ];
    };
    git = {
      enable = true;
      userName = "Simon Aronsson";
      userEmail = "simme@arcticbit.se";
      signing = {
        key = "19220CB4C0D65027";
        signByDefault = true;
      };
      lfs = {
        enable = true;
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
  };
  
  home.packages = with pkgs; [
    ctop
    dive
    gcc 
    git
    gnumake
    k6
    kubectl
    skopeo
    syft
  ];
}
