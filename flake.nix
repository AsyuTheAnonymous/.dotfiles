{
  description = "Asyu's Flake";
  # Inputs that are normally for repos and such
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    # Variables
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in {

    # System Config    
    nixosConfigurations = {
      asyus-system = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix
        ];
        specialArgs = {
          inherit pkgs-unstable;
        };
      };
    };

    # Home Manager Config
    homeConfigurations = {
      asyu = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
  };



}