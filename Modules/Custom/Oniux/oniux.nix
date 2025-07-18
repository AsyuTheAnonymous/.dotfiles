# ./Oniux/oniux.nix
{
  config,
  lib,
  pkgs,
  ...
}: let
  oniuxPackage = {
    lib,
    rustPlatform,
    fetchFromGitLab,
    nix-update-script,
  }:
    rustPlatform.buildRustPackage (finalAttrs: {
      pname = "oniux";
      version = "0.4.0";

      src = fetchFromGitLab {
        domain = "gitlab.torproject.org";
        owner = "tpo/core";
        repo = "oniux";
        tag = "v${finalAttrs.version}";
        hash = "sha256-wWB/ch8DB2tO4+NuNDaGv8K4AbV5/MbyY01oRGai86A=";
      };

      useFetchCargoVendor = true;
      cargoHash = "sha256-tUOxs9bTcXS3Gq6cHYe+eAGAEYSRvf3JVGugBImbvJM=";

      passthru.updateScript = nix-update-script {};

      meta = {
        homepage = "https://gitlab.torproject.org/tpo/core/oniux";
        description = "Isolate Applications over Tor using Linux Namespaces";
        maintainers = with lib.maintainers; [tnias];
        platforms = lib.platforms.linux;
        license = with lib.licenses; [
          asl20
          mit
        ];
        mainProgram = "oniux";
      };
    });
in {
  # This makes it a proper NixOS module
  options = {
    programs.oniux = {
      enable = lib.mkEnableOption "oniux - Isolate Applications over Tor";
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.callPackage oniuxPackage {};
        description = "The oniux package to use.";
      };
    };
  };

  config = lib.mkIf config.programs.oniux.enable {
    environment.systemPackages = [config.programs.oniux.package];
  };
}
