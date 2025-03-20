{
  config,
  lib,
  pkgs,
  ...
}: {
  nix = {
    settings = {
      download-buffer-size = 16777216;
      http-connections = 100; # Increase concurrent downloads
      max-jobs = "auto"; # Set to number of CPU cores
      cores = 0; # Use all available cores
      auto-optimise-store = true;
    };
  };
}
