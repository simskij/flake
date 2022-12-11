{
  description = "NixOS Configuration of LXD";

  # Input: nixpkgs we want to have in our configuration
  inputs = {
    # nixpkgs current branch
    nixpkgs.url = "nixpkgs/master";

    # nixpkgs fork we want (github:username/repository/branch)
    nixpkgs-lxdvm = {
      url = "github:astridyu/nixpkgs/lxd-vms";
    };
  };

  # Output: creating an overlay with our new version
  outputs = { self, nixpkgs, nixpkgs-lxdvm }:
    let
      system = "x86_64-linux";
      # Creating the overlay of our new system
      overlay-lxdvm = final: prev: {
         lxdvm = import nixpkgs-lxdvm {
           inherit system;
           # allow unfree apps
           config.allowUnfree = true;
         };
      };
    in {
      nixosConfigurations."<hostname>" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          # Creating an overlay module accessible in configuration.nix
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-lxdvm ]; })
          ./configuration.nix
        ];
      };
    };
}
