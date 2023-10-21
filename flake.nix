{
  description = "@simskij's NixOS Configuration Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    crafts = {
      url = "github:jnsgruk/crafts-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nix-darwin,
    nix-homebrew,
    homebrew-cask,
    homebrew-core,
    home-manager,
    ...
  } @ inputs:
  let
    inherit (self) outputs;
    username = "simme";
    stateVersion = "22.11";
  in
  {
    darwinConfigurations = {
      spruce = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs outputs stateVersion home-manager;
          hostname = "spruce";
          username = "simme";
        };
        modules = [
          ./systems
          ./modules/apps/nvim
          ./modules/apps/zsh
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = username;
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
              };
              mutableTaps = false;
            };
          }
        ];
      };
    };
    nixosConfigurations = {
      juniper = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs stateVersion home-manager;
          hostname = "juniper";
          username = "simme";
          hostid = "d4b231f1";
        };
        modules = [
          ./hardware
          ./systems
          ./modules
          home-manager.nixosModule {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs outputs stateVersion username;
              };
              users.simme = ./. + "/home/simme";
            };
          }
        ];
      };
    };
  };
}
