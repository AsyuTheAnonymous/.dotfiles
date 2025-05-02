{pkgs-unstable, ...}: {
  environment.systemPackages = with pkgs-unstable; [
    openvpn
    networkmanager-openvpn
  ];
}
