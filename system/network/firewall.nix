{...}: {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22 11434 3000 8080 80 53317];
    allowedUDPPorts = [53317];
  };
}
