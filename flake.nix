{
  description = "Asyu's Flake";
  # Inputs that are normally for repos and such
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @ inputs:
    # Variables
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      username = "asyu";
      name = "Ash";
    in {

    # System Config
    nixosConfigurations = {
      asyus-system = lib.nixosSystem { # System Builder Function from stable
        inherit system; # stable
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit name;
          inherit pkgs-unstable;
        };
      };
    };

    devShells.x86_64.default = (import ./dev/shell.nix { inherit pkgs;});

    # Home Manager Config
    homeConfigurations = {
      asyu = home-manager.lib.homeManagerConfiguration { # Home-manager Builder function (stable)
        inherit pkgs; # stable
        modules = [
          ./home/home.nix
         ];
         extraSpecialArgs = {
          inherit username;
          inherit name;
          inherit pkgs-unstable;
         };
      };
    };
  };

}
