{
  description = "@simskij's NixOS Configuration Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    crafts = {
      url = "github:jnsgruk/crafts-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nix-darwin,
    nix-homebrew,
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
          inherit
            inputs
            outputs
            username
            stateVersion
            home-manager;
          hostname = "spruce";
        };
        modules = [
          ./systems
          ./modules/apps/nvim
          ./modules/apps/zsh
          ./modules/base
          ./modules/homebrew
          ./modules/packages
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
        ];
      };
    };
    nixosConfigurations = {
      juniper = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {
          inherit
            inputs
            outputs
            stateVersion
            username
            home-manager;

          hostname = "juniper";
          hostid = "d4b231f1";
        };
        modules = [
          ./hardware
          ./systems
          ./modules
          home-manager.nixosModule
        ];
      };
    };
  };
}
