{
  # Flake name
  description = "Asyu's Flake";

  # Inputs are normally for repos and such
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-25.05";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # protonvpn = {
    #   url = "github:emmanuelrosa/nixos-protonvpn";
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
    nixos-generators,
    # protonvpn,
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
          ./Hosts/Desktop/desktop.nix
          stylix.nixosModules.stylix
          # protonvpn.nixosModules.protonvpn
        ];
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit name;
          inherit pkgs-unstable;
        };
      };

      # Laptop
      asyus-laptop = lib.nixosSystem {
        inherit system;
        modules = [
          ./Hosts/Laptop/laptop.nix
        ];
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit name;
          inherit pkgs-unstable;
        };
      };
    };
    # Desktop ISO
    packages.x86_64-linux = {
      desktop-iso = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "iso";
        modules = [
          ./Hosts/Desktop/desktop.nix
          ./System/ISO/iso.nix
          stylix.nixosModules.stylix
        ];
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit name;
          inherit pkgs-unstable;
          isImageTarget = true;
        };
      };
    };
    # Laptop ISO
    packages.x86_64-linux = {
      laptop-iso = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "iso";
        modules = [
          ./Hosts/Laptop/laptop.nix
          ./System/ISO/iso.nix
          stylix.nixosModules.stylix
        ];
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit name;
          inherit pkgs-unstable;
          isImageTarget = true;
        };
      };
    };
    # Home Manager Config
    homeConfigurations = {
      "asyu@asyus-system" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./Users/Home/Desktop/desktop.nix
          stylix.homeModules.stylix
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
          ./Users/Home/Laptop/laptop.nix
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
