{
  description = "Nyx OS";

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  # Flake outputs
  outputs = { self, darwin, nixpkgs, home-manager, ... }@inputs:
    let inherit (self) outputs;

    in {

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        Khaos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/Khaos ];
        };

      };

      darwinConfigurations = {
        Daedalus = darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # or x86_64-darwin
          modules = [
            ./hosts/Daedalus
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.suri = import ./users/suri;
                backupFileExtension = "backup";

              };
            }
          ];
        };
      };

    };
}
