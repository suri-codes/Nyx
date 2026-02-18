{
  description = "Nyx OS";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix.url = "github:helix-editor/helix";

  };

  # Flake outputs
  outputs =
    {
      self,
      darwin,
      nixpkgs,
      helix,
      home-manager,
      ...
    }@inputs:
    let
      overlays = [ ];
    in
    {
      # `sudo nixos-rebuild switch --flake .#Khaos`
      nixosConfigurations = {
        Khaos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            outputs = self;
          };
          modules = [
            ./hosts/Khaos
            home-manager.nixosModules.home-manager
            { nixpkgs.overlays = overlays; }
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.suri = import ./users/suri/Khaos.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = {
                  # <-- add this
                  helix = helix;
                };
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
            home-manager.darwinModules.home-manager
            { nixpkgs.overlays = overlays; }
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.suri = import ./users/suri/Daedalus.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = {
                  # <-- add this
                  helix = helix;
                };
              };
            }
          ];
        };
      };

    };
}
