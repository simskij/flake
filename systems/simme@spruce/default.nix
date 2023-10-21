{ stateVersion, pkgs, ... }:
let on = { enable = true; };
in
{
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
  };
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
    };
  };

  services = {
    nix-daemon = {
      enable = true;
    };
  };

  system = {
    stateVersion = 4;
  };

  users.users.simme = {
    name = "simme";
    home = "/Users/simme";
  };

  programs.zsh.enable = true;

  arctic = {
    apps = {
      nvim = on // {
        settings = {
          tab-width = 2;
          numbers = true;
        };
        plugins = {
          devicons = on;
          easy-align = on;
          gitgutter = on;
          mason = on;
          telescope = on;
          terminal = on;
          tree = on;
        };
      };
      zsh = on // {
        dots = ".config/zsh";
        aliases = {
          auth           = "ssh-add ~/.ssh/id_rsa";
          ll             = "ls -la";
          reload         = "echo \"usage: reload.[nixos|shell]\"";
          "reload.nixos" = "sudo nixos-rebuild switch --flake ~/code/simskij/nixos-config";
          "reload.shell" = "source ~/.zshrc";
        };
        addons = {
          starship = on;
        };
      };
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.simme = {
      home = {
        stateVersion = stateVersion;
        packages = with pkgs; [
          nodejs
          cargo
        ];
      }; 
    };
  };
}
