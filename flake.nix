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

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  # Flake outputs
  outputs = { self, darwin, nixpkgs, home-manager, rust-overlay, ... }@inputs:
    let overlays = [ rust-overlay.overlays.default ];
    in {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      # `sudo nixos-rebuild switch --flake .#Khaos`
      nixosConfigurations = {
        Khaos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            outputs = self;
          };
          modules = [
            ./hosts/Khaos

            { nixpkgs.overlays = overlays; }
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.suri = import ./users/suri/Khaos.nix;
                backupFileExtension = "backup";
              };
            }

          ];
        };
      };

      # `darwin-rebuild switch --flake .#Daedalus`
      darwinConfigurations = {
        Daedalus = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs;
            outputs = self;
          };
          modules = [
            ./hosts/Daedalus
            { nixpkgs.overlays = overlays; }
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.suri = import ./users/suri/Deadalus.nix;
                backupFileExtension = "backup";
              };
            }
          ];
        };
      };

    };
}
