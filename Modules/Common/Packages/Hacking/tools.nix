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
  ];

  boot.extraModulePackages = [config.boot.kernelPackages.rtl8814au];
  boot.kernelModules = ["8814au"];
}
