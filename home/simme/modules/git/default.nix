{ pkgs, ... }: {
  programs = {
    gh = {
      enable = true;
      enableGitCredentialHelper = true;
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
}
