{
  description = "@simskij's NixOS Configuration Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager";
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
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      stateVersion = "22.11";
    in
    {
      overlays = import ./overlays { inherit inputs; };
      
      # devShells = forAllSystems (system:
      #   let pkgs = nixpkgs-unstable.legacyPackages.${system};
      #   in pkgs.mkShell {
      #     NIX_CONFIG = "experimental-features = nix-command flakes";
      #     nativeBuildInputs = with pkgs; [ nix home-manager git ];
      #   }
      # );

      formatter = forAllSystems (system:
        let pkgs = nixpkgs-unstable.legacyPackages.${system};
        in pkgs.nixpkgs-fmt
      );

      homeConfigurations = {
        "simme@juniper" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs stateVersion;
            hostname = "juniper";
            username = "simme";
          };
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

        juniper = nixpkgs-unstable.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs stateVersion;
            hostname = "juniper";
            hostid = "d4b231f1";
            username = "simme";
          };
          modules = [
            ./host
          ];
        };
      };
    };
}
