{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./ReconFTW/reconftw.nix
    ./XSStrike/xsstrike.nix
    (pkgs.callPackage ./Oniux/oniux.nix {})

  ];
  services.reconftw = {
    enable = false;
    # Optional: Specify a custom config file
    # configFile = "/path/to/your/reconftw.cfg";
  };
  # Enable XSStrike
  services.xsstrike = {
    enable = true;
    # Optional: Specify a custom config directory
    # configFileDir = "/custom/path/to/xsstrike/config";
  };
}
