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
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
  };
}
