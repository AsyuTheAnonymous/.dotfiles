# xsstrike.nix - NixOS module for XSStrike
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.xsstrike;
  
  # Create a derivation for XSStrike using stdenv instead of Python's buildPythonApplication
  xsstrike-pkg = pkgs.stdenv.mkDerivation {
    pname = "xsstrike";
    version = "3.1.6"; # Update this as needed
    
    src = pkgs.fetchFromGitHub {
      owner = "s0md3v";
      repo = "XSStrike";
      rev = "master"; # You can specify a specific commit or tag here
      sha256 = "sha256-8H6/OZRKrF5dd4NcZ6Km3mxBSK6UkY1LpmgITAXG/AU="; # Replace with your hash if needed
    };
    
    # Required dependencies
    buildInputs = with pkgs; [
      python3
      python3Packages.fuzzywuzzy
      python3Packages.levenshtein
      python3Packages.prettytable
      python3Packages.requests
      python3Packages.tld
      python3Packages.urllib3
    ];
    
    # No build phase needed
    dontBuild = true;
    
    # Custom installation phase
    installPhase = ''
      # Create directories
      mkdir -p $out/lib/xsstrike
      mkdir -p $out/bin
      
      # Copy all files to the lib directory
      cp -r * $out/lib/xsstrike/
      
      # Create a wrapper script
      cat > $out/bin/xsstrike << EOF
#!/bin/sh
export PYTHONPATH="${with pkgs.python3Packages; 
  pkgs.lib.makeSearchPath "lib/python3.12/site-packages" [
    fuzzywuzzy
    levenshtein
    prettytable
    requests
    tld
    urllib3
  ]}:\$PYTHONPATH"
cd $out/lib/xsstrike
exec ${pkgs.python3}/bin/python3 $out/lib/xsstrike/xsstrike.py "\$@"
EOF
      
      # Make the wrapper executable
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