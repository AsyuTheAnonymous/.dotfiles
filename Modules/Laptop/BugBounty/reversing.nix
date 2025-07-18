# Reverse Engineering Tools for Bug Bounty - Laptop Optimized
{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment.systemPackages = with pkgs-unstable; [
    # Core tools - lightweight alternatives where possible
    ghidra # NSA reverse engineering suite
    radare2 # Lightweight alternative to IDA Pro
    rizin # Fork of radare2, sometimes more efficient
    cutter # GUI for radare2/rizin

    # Mobile reversing tools
    apktool
    dex2jar
    jadx # Dex to Java decompiler

    # Binary analysis
    binwalk # Firmware analysis
    foremost # File carving
    strings # Extract strings from binary

    # Debuggers
    gdb # GNU Debugger
    gef # GDB Enhanced Features
    pwndbg # GDB for exploit developers

    # Disassemblers
    objdump

    # Memory analysis
    volatility # Memory forensics

    # Monitoring
    strace # System call tracer
    ltrace # Library call tracer

    # Network analysis - lightweight alternatives
    wireshark-cli # CLI alternative to GUI Wireshark
    tshark # TShark is more resource-efficient for laptops
    tcpdump

    # Hex editors
    xxd
    hexdump
    hexedit

    # Web deobfuscation
    js-beautify
    python3Packages.jsbeautifier

    # Create launcher scripts for resource-intensive tools
    (pkgs.writeShellScriptBin "ghidra-laptop" ''
      #!/usr/bin/env bash
      # Optimized Ghidra launcher for laptop

      # Check if connected to power
      ON_BATTERY=true
      if [ -d /sys/class/power_supply ]; then
        for battery in /sys/class/power_supply/*/type; do
          if [ -f "$battery" ]; then
            if grep -q "Battery" "$battery"; then
              battery_dir=$(dirname "$battery")
              if [ -f "$battery_dir/status" ]; then
                if ! grep -q "Discharging" "$battery_dir/status"; then
                  ON_BATTERY=false
                fi
              fi
            fi
          fi
        done
      fi

      if [ "$ON_BATTERY" = true ]; then
        echo "[!] Warning: Running Ghidra on battery power may drain your battery quickly."
        echo "[!] It is recommended to connect your laptop to AC power."
        read -p "Continue anyway? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
          exit 1
        fi
      fi

      # Create a memory-optimized configuration
      GHIDRA_CONF_DIR="$HOME/.ghidra"
      mkdir -p "$GHIDRA_CONF_DIR"

      # Launch with optimized JVM settings
      export _JAVA_OPTIONS="-Xms512m -Xmx2g -Dsun.java2d.opengl=true"
      ghidra "$@"
    '')

    # Low-memory GDB wrapper
    (pkgs.writeShellScriptBin "gdb-laptop" ''
      #!/usr/bin/env bash
      # Memory-efficient GDB wrapper

      # Lower priority to prevent system slowdown
      exec nice -n 10 gdb "$@"
    '')

    # Mobile APK analyzer script
    (pkgs.writeShellScriptBin "analyze-apk" ''
      #!/usr/bin/env bash
      # Script to analyze Android APKs efficiently on laptop

      if [ $# -lt 1 ]; then
        echo "Usage: analyze-apk <apk-file>"
        exit 1
      fi

      APK_FILE=$1
      BASENAME=$(basename "$APK_FILE" .apk)
      OUTDIR="$HOME/BugBounty/Targets/mobile/$BASENAME"
      mkdir -p "$OUTDIR"

      echo "[+] Analyzing APK: $APK_FILE"
      echo "[+] Output directory: $OUTDIR"

      # Extract the APK
      echo "[+] Extracting APK with apktool..."
      apktool d -o "$OUTDIR/apktool" -f "$APK_FILE"

      # Convert to JAR
      echo "[+] Converting to JAR with dex2jar..."
      dex2jar "$APK_FILE" -o "$OUTDIR/$BASENAME.jar"

      # Extract with jadx (more memory efficient than GUI)
      echo "[+] Extracting with jadx..."
      jadx -d "$OUTDIR/jadx" "$APK_FILE"

      # Basic analysis
      echo "[+] Extracting manifest..."
      cp "$OUTDIR/apktool/AndroidManifest.xml" "$OUTDIR/AndroidManifest.xml"

      echo "[+] Looking for interesting strings..."
      strings "$APK_FILE" | grep -i -E "password|token|api|key|secret|url|http|config" > "$OUTDIR/interesting_strings.txt"

      echo "[+] Checking for hardcoded secrets..."
      grep -r -i -E "password|token|api|key|secret" "$OUTDIR/jadx" > "$OUTDIR/hardcoded_secrets.txt"

      echo "[+] Finding network communications..."
      grep -r -i -E "http|https|url|connect" "$OUTDIR/jadx" > "$OUTDIR/network_comms.txt"

      echo "[+] Analysis complete! Results saved to $OUTDIR"
      echo "[+] For more detailed analysis, you can open the JAR file with JD-GUI or use:"
      echo "    - jadx-gui $APK_FILE (if you have resources available)"
    '')
  ];

  # Configure system for binary analysis
  # Enable core dumps for debugging but limit size for laptop storage
  systemd.coredump = {
    enable = true;
    extraConfig = {
      Storage = "external";
      ProcessSizeMax = "1G";
      ExternalSizeMax = "1G";
    };
  };

  # Set up reversing environment with pre-configured config files
  environment.etc = {
    # GEF (GDB Enhanced Features) configuration
    "bugbounty/gdbinit".text = ''
      # GEF configuration optimized for laptop
      source ${pkgs.gef}/share/gef.py

      # Reduce memory usage
      gef config context.nb_lines_backtrace 3
      gef config context.nb_lines_code 5
      gef config context.nb_lines_stack 5
      gef config context.redirect /dev/null

      # Only show essential info
      gef config context.enable True
      gef config context.layout "legend regs stack code source threads trace extra memory"
    '';

    # Radare2 configuration
    "bugbounty/radare2rc".text = ''
      # Laptop-optimized radare2 configuration
      e cfg.fortunes=false
      e dbg.bpinmaps=true
      e scr.color=2
      e scr.interactive=true

      # Reduce memory usage
      e cfg.bigendian=false
      e io.cache=true
      e io.buffer=true

      # Analysis options
      e anal.hasnext=true
      e anal.jmptbl=true
    '';
  };
}
