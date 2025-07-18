# Bug Bounty Environment for Laptop
{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./recon.nix # Reconnaissance tools optimized for laptop
    ./exploits.nix # Exploitation frameworks with laptop resources in mind
    ./reversing.nix # Reverse engineering tools
    ./web.nix # Web application security tools
    ./workflows.nix # Automated workflows and shortcuts
  ];

  # Battery-optimized system settings for a laptop
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "powersave"; # Change to "performance" when plugged in via script
  };

  # Set up an isolated network namespace for your testing
  # This prevents accidental connections from your bug bounty tools to unintended targets
  virtualisation.containers = {
    enable = true;
    containersConf.settings = {
      engine.network_cmd_options = ["--ipvlan"];
    };
  };

  # VPN auto-connect for bug bounty work
  networking.networkmanager.dispatcherScripts = [
    {
      source = ./vpn-autoconnect.sh;
      type = "basic";
    }
  ];

  # Default terminal with predefined layouts for bug bounty work
  environment.variables = {
    BUGBOUNTY_WORKSPACE = "$HOME/BugBounty";
    BUGBOUNTY_TOOLS = "$HOME/BugBounty/Tools";
    BUGBOUNTY_TARGETS = "$HOME/BugBounty/Targets";
    BUGBOUNTY_REPORTS = "$HOME/BugBounty/Reports";
  };

  # System-wide environment variables for tools
  environment.variables = {
    # Proxy settings for tools
    BURP_PROXY = "http://127.0.0.1:8080";
    ZAP_PROXY = "http://127.0.0.1:8090";

    # Resource management for laptops
    PARALLEL_THREADS = "4"; # Conservative default, adjust based on your CPU

    # Default paths for common tools
    PATH = [
      "$BUGBOUNTY_TOOLS/bin"
    ];
  };
}
