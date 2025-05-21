{
  config,
  pkgs-unstable,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs-unstable; [
    aircrack-ng
    nmap
    kismet
    wifite2
    metasploit
    wireshark
    armitage
    bluez
    bluez-tools
    ubertooth
    john
    hashcat
    bettercap
    burpsuite
    subfinder
    katana
    nuclei
    httpx
    caido
    dnsrecon
    prometheus
    nikto
    ffuf
    amass
    gobuster
    exiftool
    interactsh
    masscan
    dalfox
    gowitness
    thc-hydra
    arjun
    tor
    torsocks
    postman
    graphqlmap
    altair
    popsicle
    update-systemd-resolved
    tor-browser
    qflipper
    feroxbuster
    xnlinkfinder
    dig
    # (import ./FSRecon/fsrecon.nix {
    #   inherit (pkgs) lib stdenv nmap subfinder gobuster httpx gowitness nuclei makeWrapper bash;
    # })
  ];
  # Enable Wireshark, hopefully fixing root
  programs.wireshark.enable = true;

  hardware.flipperzero.enable = true;


  # Enable Tor and Privoxy for HTTP(S) proxying over Tor
  services.tor = {
    enable = true;
    client.enable = true; # Enables fast SOCKS port (9063) for Privoxy
    client.dns.enable = true;
    settings.DNSPort = [
      {
        addr = "127.0.0.1";
        port = 53;
      }
    ];
  };
  services.resolved = {
    enable = true;
    fallbackDns = [""];
  };
  services.privoxy = {
    enable = true;
    enableTor = true; # Automatically forwards HTTP to Tor's SOCKS port
  };
  networking.nameservers = ["127.0.0.1"];

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

  # THM Labs
  networking.hosts = {
    "10.10.191.61" = [ "nahamstore.thm" "www.nahamstore.thm" ];
  };

}
