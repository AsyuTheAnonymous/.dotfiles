{
  # Flake name
  description = "Asyu's Flake";

  # Inputs are normally for repos and such
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-24.11";
    # nixos-generators = { 
    #   url = "github:nix-community/nixos-generators";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
  # Outputs
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    stylix,
    # nixos-generators,
    ...
  } @ inputs:
  # Variables
  let
    # System Settings
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    # locale = "en-US.UTF-8";
    # timezone = "America/Chicago";
    # User Settings
    username = "asyu";
    name = "Ash";

    # Packages
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      # overlays = [
      # # Lets make sense of this.. (Final = end resultof prev) (Prev = package we are overlaying)
      # (final: prev: {
      # })
      # ];
    };

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

  in {
    # System Config
    nixosConfigurations = {
      # Desktop
      asyus-system = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/desktop/desktop.nix
          stylix.nixosModules.stylix
        ];
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit name;
          inherit pkgs-unstable;
        };
      };
      # desktopImage = nixpkgs.lib.nixosSystem {
      #   specialArgs = { inherit inputs; };
      #   modules = [
      #     ./vm/desktop/configuration.nix
      #   ];
      # };
      # Laptop
      asyus-laptop = lib.nixosSystem {
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
      "asyu@asyus-system" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/desktop.nix
          stylix.homeManagerModules.stylix
        ];
        extraSpecialArgs = {
          inherit username;
          inherit name;
          inherit pkgs-unstable;
        };
      };
      "asyu@asyus-laptop" = home-manager.lib.homeManagerConfiguration {
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
