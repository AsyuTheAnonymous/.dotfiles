{ config, lib, pkgs, ... }: {
    imports = [
        ./ReconFTW/reconftw.nix
        ./XSStrike/xsstrike.nix
    ];
    services.reconftw = {
        enable = true;
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