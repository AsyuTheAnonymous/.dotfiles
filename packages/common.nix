{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    brave
    parsec-bin
    protonmail-desktop
    gnome-boxes
    neofetch
    pavucontrol
    bottles
    localsend
    unzip
    unrar
    zip
    tree
    okular
    wirelesstools
    usbutils
    iw
    git
    impression
    putty
    nh
    nix-output-monitor
    nvd
    alejandra
  ];
}
