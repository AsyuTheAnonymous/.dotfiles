{
  config,
  pkgs-unstable,
  ...
}: {
  environment.systemPackages = with pkgs-unstable; [
    aircrack-ng
    wireshark
    nmap
    kismet
    wifite2
    metasploit
    armitage
    john
    hashcat
    bettercap
    burpsuite
    subfinder
    katana
    nuclei
    httpx
    caido
    prometheus
    nikto
    ffuf
    amass
    gobuster
    exiftool
    interactsh
    thc-hydra
    tor
    torsocks
    postman
  ];


# Enable Tor and Privoxy for HTTP(S) proxying over Tor
  services.tor = {
    enable = true;
    client.enable = true; # Enables fast SOCKS port (9063) for Privoxy
    client.dns.enable = true;
    settings.DNSPort =[{
      addr = "127.0.0.1";
      port = 53;
    }];
  };
  services.resolved = {
    enable = true;
    fallbackDns = [ "" ];
  };
  services.privoxy = {
    enable = true;
    enableTor = true; # Automatically forwards HTTP to Tor's SOCKS port
  };
  networking.nameservers = [ "127.0.0.1" ];

  # # Tor Service
  # services.tor = {
  #   enable = true;
  #   openFirewall = true;
  #   relay = {
  #     enable = true;
  #     role = "relay";
  #   };
  #   settings = {
  #     ContactInfo = "toradmin@example.org";
  #     Nickname = "toradmin";
  #     ORPort = 9001;
  #     ControlPort = 9051;
  #     BandWidthRate = "1 MBytes";
  #     SocksPort = 9050;
  #   };
  # };
  # Wifi "Adapter" drivers
  boot.extraModulePackages = [config.boot.kernelPackages.rtl8814au];
  boot.kernelModules = ["8814au"];
}
