# Master Bug Bounty Module for Laptop
{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./BugBounty
  ];

  # Create the essential directory structure
  system.activationScripts = {
    createBugBountyDirs = {
      text = ''
        # Create base directories for Bug Bounty
        mkdir -p /home/asyu/BugBounty/{Tools,Targets,Reports,Templates,Scripts,notes,payloads}

        # Create subdirectories for organization
        mkdir -p /home/asyu/BugBounty/Tools/{recon,exploit,web,mobile}
        mkdir -p /home/asyu/BugBounty/Templates/{reports,notes,scripts}

        # Set permissions
        chown -R asyu:users /home/asyu/BugBounty
      '';
      deps = [];
    };
  };

  # Add default configuration files
  environment.etc = {
    "bugbounty/README.md".text = ''
      # Bug Bounty Environment

      This environment is pre-configured for bug bounty hunting on a laptop with resource-efficient tools and workflows.

      ## Directory Structure

      - `~/BugBounty/Tools/` - Tools organized by category
      - `~/BugBounty/Targets/` - Target-specific information and findings
      - `~/BugBounty/Reports/` - Bug reports and write-ups
      - `~/BugBounty/Templates/` - Templates for reports and notes
      - `~/BugBounty/Scripts/` - Custom scripts and automation

      ## Available Commands

      ### Workflow Management
      - `bb-workflow` - Main workflow manager
      - `bb-track start/stop/status/summary` - Time tracking
      - `bb-recon-multi` - Multi-target reconnaissance

      ### Reconnaissance
      - `laptop-recon <domain>` - Battery-friendly recon
      - `power-recon <domain>` - Full recon (when plugged in)

      ### Web Testing
      - `web-enum <url>` - Basic web enumeration
      - `xss-scan <url> [param1,param2,...]` - XSS scanning
      - `sqli-scan <url> [param1,param2,...]` - SQLi scanning

      ### Mobile Testing
      - `analyze-apk <apk-file>` - Basic APK analysis

      ### System Management
      - `toggle-power-mode` - Switch between power-saving and performance
      - `eco-launch <program> [args...]` - Launch programs with battery considerations
      - `setup-exploit-env` - Set up containerized exploitation environment
      - `teardown-exploit-env` - Stop containers to save resources

      ## Tips for Laptop Use

      - Use `laptop-recon` for basic reconnaissance when on battery
      - Use `power-recon` when connected to power for more thorough scanning
      - Use `eco-launch` to start resource-intensive programs with battery considerations
      - Enable VPN before starting any testing (auto-connect script is enabled)
      - Use tmux sessions with `start-bb-session` to organize your workflow
      - Track your time with `bb-track` for later reporting
    '';

    # Basic .gitignore for bug bounty directory
    "bugbounty/gitignore".text = ''
      # Bug Bounty .gitignore

      # Ignore sensitive information
      *.key
      *.pem
      *.token
      *.secret
      *password*

      # Ignore large files and databases
      *.db
      *.sqlite
      *.backup

      # Ignore logs and temporary files
      *.log
      *.tmp

      # Tool-specific files
      .burp/
      .zap/

      # Custom directories to exclude
      private/
    '';
  };

  # Set up a desktop shortcut for quick access
  environment.systemPackages = with pkgs; [
    (writeTextFile {
      name = "bugbounty-desktop";
      destination = "/home/asyu/.local/share/applications/bugbounty.desktop";
      text = ''
        [Desktop Entry]
        Name=Bug Bounty Workflow
        Comment=Start Bug Bounty Workflow
        Exec=bash -c "cd ~/BugBounty && kitty -e bb-workflow"
        Icon=applications-hacking
        Terminal=false
        Type=Application
        Categories=Security;
      '';
    })
  ];
}
