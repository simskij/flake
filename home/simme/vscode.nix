{ inputs, lib, config, pkgs, ... }: {

  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
        esbenp.prettier-vscode
        jnoortheen.nix-ide
        bierner.emojisense
        ms-pyright.pyright
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "go";
          publisher = "golang";
          version = "0.33.1";
          sha256 = "LyQHaTJ39meZ4R0QzzFVsJelO/S5EPdXCxyyRoDuUjc=";
        }
        {
          name = "catppuccin-vsc";
          publisher = "Catppuccin";
          version = "2.5.0";
          sha256 = "77s+IXMGJi1ZpNTNZ+ztAYYRqo2CU7xUBCvXq/1f+nk=";
        }
        {
          name = "remote-ssh";
          publisher = "ms-vscode-remote";
          version = "0.95.2022121315";
          sha256 = "C9V9DmFaD6NNZQZcfJSv94Ga1u04UjqL/QGrVq2htL4=";
        }
        {
          name = "remote-explorer";
          publisher = "ms-vscode";
          version = "0.1.2022121209";
          sha256 = "B6Ix23/xPpBG3lsDpXHUnDmK03D5arjUYoY5Ceyn0I0=";

        }
      ];
    };
  };
}
