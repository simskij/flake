{
  description = "@simskij's NixOS Configuration Flake";
  inputs = {
    nixpkgs.url = "nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , disko
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      stateVersion = "22.11";
      system = "x86_64-linux";
    in
    {
      overlays = import ./overlays { inherit inputs; };

      homeConfigurations = {
        "simme" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [ ./home/simme ];
        };
      };

      nixosConfigurations = {
        pine = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs stateVersion;
            hostname = "pine";
            hostid = "007f0200";
            username = "simme";
          };
          modules = [ ./host ];
        };

        juniper = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs stateVersion;
            hostname = "juniper";
            hostid = "d4b231f1";
            username = "simme";
          };
          modules = [ ./host ];
        };
      };
    };
}
