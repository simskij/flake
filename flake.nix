{
    description = "@simskij's NixOS Configuration Flake";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
   
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
        home-manager,
        ...
    } @ inputs:
    let
        inherit (self) outputs;
        username = "simme";
        stateVersion = "22.11";
    in
    {

      nixosConfigurations = {
        juniper = nixpkgs-unstable.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs stateVersion home-manager;
            hostname = "juniper";
            hostid = "d4b231f1";
            username = "simme";
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
                        users."${username}" = ./. + "/home/${username}";
                    };
              }
          ];
        };
      };
    };
}
