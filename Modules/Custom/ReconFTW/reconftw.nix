# reconftw.nix - NixOS module for reconftw
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.reconftw;
in {
  options = {
    services.reconftw = {
      enable = mkEnableOption "reconftw reconnaissance tool";
      
      dataDir = mkOption {
        type = types.str;
        default = "/var/lib/reconftw";
        description = "Directory to store reconftw data";
      };
      
      configFile = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = "Custom reconftw.cfg configuration file";
      };
    };
  };
  
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (pkgs.stdenv.mkDerivation {
        pname = "reconftw";
        version = "3.0.0"; # You can update this version as needed
        
        src = pkgs.fetchFromGitHub {
          owner = "six2dez";
          repo = "reconftw";
          rev = "main"; # You can specify a specific commit or tag here
          sha256 = "sha256-ykwmZa3AbLRivJ/KIgsGARq7UUCxUfmTxlvKeEhB5mY="; # Replace with the hash from nix-prefetch-github six2dez reconftw main
        };
        
        # Required dependencies
        buildInputs = with pkgs; [
          git
          python3
          python3Packages.pip
          python3Packages.setuptools
          python3Packages.wheel
          go
          jq
          wget
          curl
          nmap
          whois
          bind
          nodejs
          openssl
          unzip
          procps
          findutils
          gawk
          gnused
          gnugrep
          coreutils
          # Add other dependencies as needed
        ];
        
        # Don't use the reconftw installer script since we're managing dependencies with Nix
        buildPhase = ''
          # Create data directories
          mkdir -p $out/opt/reconftw
          cp -r * $out/opt/reconftw/
          
          # Make the reconftw script executable
          chmod +x $out/opt/reconftw/reconftw.sh
          
          # Create a wrapper script
          mkdir -p $out/bin
          cat > $out/bin/reconftw << EOF
          #!/bin/sh
          # Set necessary environment variables
          export HOME=\''${HOME:-/tmp}
          export GOPATH=\''${GOPATH:-\$HOME/go}
          export PATH=\$PATH:\$GOPATH/bin
          
          # Create data directory if it doesn't exist
          mkdir -p ${cfg.dataDir}/Tools
          mkdir -p ${cfg.dataDir}/Recon
          
          # Run reconftw
          cd $out/opt/reconftw
          if [ -f "${cfg.configFile}" ]; then
            exec ./reconftw.sh -c "${cfg.configFile}" "\$@"
          else
            exec ./reconftw.sh "\$@"
          fi
          EOF
          
          chmod +x $out/bin/reconftw
        '';
        
        installPhase = "true"; # We do everything in buildPhase
        
        meta = with lib; {
          description = "A tool designed to perform automated recon on a target domain";
          homepage = "https://github.com/six2dez/reconftw";
          license = licenses.mit;
          platforms = platforms.unix;
        };
      })
    ];
    
    # Create data directory
    system.activationScripts.reconftw = ''
      mkdir -p ${cfg.dataDir}/Tools
      mkdir -p ${cfg.dataDir}/Recon
      chmod -R 755 ${cfg.dataDir}
    '';
  };
}
