{
  config,
  lib,
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
    john
    hashcat
    bettercap
  ];

  boot.extraModulePackages = [config.boot.kernelPackages.rtl8814au];
  boot.kernelModules = ["8814au"];
}
