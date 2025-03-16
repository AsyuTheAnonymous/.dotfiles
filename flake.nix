{
  description = "Asyu's Flake";
  # Inputs that are normally for repos and such
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, stylix, hyprpanel, ... } @ inputs:
    # Variables
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ inputs.hyprpanel.overlay ];
      };
      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      username = "asyu";
      name = "Ash";
    in {

    # System Config
    nixosConfigurations = {
      # Desktop
      desktop = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/desktop/desktop.nix
        ];
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit name;
          inherit pkgs-unstable;
        };
      };
      # Laptop
      laptop = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/laptop/laptop.nix
        ];
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit name;
          inherit pkgs-unstable;
        };
      };
    };
    # Home Manager Config
    homeConfigurations = {
      "asyu@desktop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/desktop.nix
        ];
        extraSpecialArgs = {
          inherit username;
          inherit name;
          inherit pkgs-unstable;
        };
      };
      "asyu@laptop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/laptop.nix
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
