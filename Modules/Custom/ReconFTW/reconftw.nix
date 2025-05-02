# reconftw.nix - NixOS module for reconftw
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.reconftw;

  # Create a derivation for reconftw
  reconftw-pkg = pkgs.stdenv.mkDerivation {
    pname = "reconftw";
    version = "3.0.0"; # Using your version from logs

    src = pkgs.fetchFromGitHub {
      owner = "six2dez";
      repo = "reconftw";
      rev = "main";
      sha256 = "sha256-ykwmZa3AbLRivJ/KIgsGARq7UUCxUfmTxlvKeEhB5mY="; # Using your existing hash
    };

    nativeBuildInputs = with pkgs; [makeWrapper];

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
    ];

    # Skip the bootstrap and build phases that are failing
    dontBuild = true;

    # Prevent the installer from trying to run
    # Disable any Makefile operations
    preInstall = ''
      # If Makefile exists, move it away
      if [ -f Makefile ]; then
        mv Makefile Makefile.orig
      fi

      # Same for install.sh
      if [ -f install.sh ]; then
        mv install.sh install.sh.orig
      fi
    '';

    installPhase = ''
      # Create directories
      mkdir -p $out/opt/reconftw
      mkdir -p $out/bin

      # Copy all files to the output directory
      cp -r * $out/opt/reconftw/

      # Make the reconftw script executable
      chmod +x $out/opt/reconftw/reconftw.sh

      # Create a wrapper script with makeWrapper
      makeWrapper $out/opt/reconftw/reconftw.sh $out/bin/reconftw \
        --prefix PATH : ${lib.makeBinPath (with pkgs; [
        git
        python3
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
      ])} \
        --run "export HOME=\''${HOME:-/tmp}; mkdir -p \$HOME/Tools \$HOME/go ${cfg.dataDir}/Tools ${cfg.dataDir}/Recon" \
        --set GOPATH "\$HOME/go" \
        --set PATH "$PATH:\$HOME/go/bin" \
        --set RECONFTW_HOME "${cfg.dataDir}"
    '';

    meta = with lib; {
      description = "A tool designed to perform automated recon on a target domain";
      homepage = "https://github.com/six2dez/reconftw";
      license = licenses.mit;
      platforms = platforms.unix;
    };
  };
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
    environment.systemPackages = [reconftw-pkg];

    # Create data directory using a structured activation script
    system.activationScripts = {
      reconftw-dirs = {
        text = ''
          mkdir -p ${cfg.dataDir}/Tools
          mkdir -p ${cfg.dataDir}/Recon
          chmod -R 755 ${cfg.dataDir}
        '';
        deps = [];
      };
    };

    # If user provided a config file, create a symlink
    environment.etc = mkIf (cfg.configFile != null) {
      "reconftw/reconftw.cfg".source = cfg.configFile;
    };
  };
}
