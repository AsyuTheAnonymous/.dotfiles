{ pkgs-unstable, ... }: {
    environment.systemPackages = with pkgs-unstable; [
        protonvpn-gui
    ];

}