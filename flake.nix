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
    let
      overlays = [ rust-overlay.overlays.default ];
      mkPkgs = system:
        import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };

    in {

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        Khaos = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/Khaos { nixpkgs.overlays = overlays; } ];
        };
      };

      darwinConfigurations = {
        Daedalus = darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # or x86_64-darwin
          modules = [
            ./hosts/Daedalus
            { nixpkgs.overlays = overlays; }
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

      homeConfigurations = {
        "suri@Daedalus" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "aarch64-darwin";
          modules = [ ./users/suri/Daedalus.nix ];
        };

        "suri@Khaos" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "x86_64-linux";
          modules = [ ./users/suri/Khaos.nix ];
        };
      };

    };
}
