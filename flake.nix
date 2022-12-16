{
  description = "@simskij's NixOS Configuration Flake";
  inputs = {
    nixpkgs.url = "nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
    in
    {
      homeConfigurations = {
        "simme@juniper" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [
            ./home/simme
          ];
        };
      };

      nixosConfigurations = {
        juniper = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./systems/juniper/configuration.nix
            ./systems/juniper/bluetooth.nix
            ./systems/juniper/boot.nix
            ./systems/juniper/hardware-configuration.nix
            ./systems/juniper/networking.nix
            ./systems/juniper/networking.nix
            ./systems/juniper/users.nix
            ./systems/juniper/steam.nix
            ./systems/juniper/virtualization.nix
            ./systems/juniper/locale.nix
          ];
        };
      };
    };
}
