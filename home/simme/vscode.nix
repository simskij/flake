{ inputs, lib, config, pkgs, ... }: {

  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscodium;
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
      ];
    };
  };
}
