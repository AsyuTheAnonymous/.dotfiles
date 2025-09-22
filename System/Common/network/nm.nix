{pkgs, ...}: {
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager = {
    enable = true; # Easiest to use and most distros use this by default.
    plugins = [
      pkgs.networkmanager-openvpn
      # pkgs.networkmanager-wireguard
    ];
  };
  networking.wireguard.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  services.resolved.enable = true;
  networking.firewall.checkReversePath = false;
}
