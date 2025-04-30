{ config, lib, pkgs, ... }: 


{
  services.protonvpn = {
    enable = true;
    autoStart = true;  # Set to false if you don't want it to start automatically
    
    # Option 1: Store credentials directly (less secure but simpler)
    authentication = "/home/asyu/secrets/proton.txt";
    
    # Choose a server (optional)
    server = "us.protonvpn.com";  # Use a specific country server
  };
}