{...}: {
  nix = {
    settings = {
      download-buffer-size = 524288000;
      http-connections = 100; # Increase concurrent downloads
      max-jobs = "auto"; # Set to number of CPU cores
      cores = 0; # Use all available cores
      auto-optimise-store = true;
    };
  };
}
