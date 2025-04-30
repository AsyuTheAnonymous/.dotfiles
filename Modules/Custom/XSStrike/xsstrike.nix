# xsstrike.nix - NixOS module for XSStrike
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.xsstrike;
  
  # Create a derivation for XSStrike
  xsstrike-pkg = pkgs.python3Packages.buildPythonApplication {
    pname = "xsstrike";
    version = "3.1.6"; # Update this as needed
    
    src = pkgs.fetchFromGitHub {
      owner = "s0md3v";
      repo = "XSStrike";
      rev = "master"; # You can specify a specific commit or tag here
      sha256 = "sha256-8H6/OZRKrF5dd4NcZ6Km3mxBSK6UkY1LpmgITAXG/AU="; # Replace with hash from nix-prefetch-github s0md3v XSStrike master
    };
    
    propagatedBuildInputs = with pkgs.python3Packages; [
      fuzzywuzzy
      python-levenshtein
      prettytable
      requests
      tld
    ];
    
    # Disable tests as they might require network access
    doCheck = false;
    
    # Create a wrapper script
    postInstall = ''
      mkdir -p $out/bin
      cat > $out/bin/xsstrike << EOF
#!/bin/sh
exec ${pkgs.python3}/bin/python3 $out/lib/python*/site-packages/xsstrike.py "\$@"
EOF
      chmod +x $out/bin/xsstrike
    '';
    
    meta = with lib; {
      description = "The most advanced XSS scanner";
      homepage = "https://github.com/s0md3v/XSStrike";
      license = licenses.gpl3;
      platforms = platforms.unix;
    };
  };
in {
  options = {
    services.xsstrike = {
      enable = mkEnableOption "XSStrike XSS scanner";
      
      # Options for customization
      configFileDir = mkOption {
        type = types.str;
        default = "/var/lib/xsstrike";
        description = "Directory to store XSStrike configuration";
      };
    };
  };
  
  config = mkIf cfg.enable {
    environment.systemPackages = [ xsstrike-pkg ];
    
    # Create config directory
    system.activationScripts = {
      xsstrike-dirs = {
        text = ''
          mkdir -p ${cfg.configFileDir}
          chmod -R 755 ${cfg.configFileDir}
        '';
        deps = [];
      };
    };
  };
}