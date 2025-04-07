{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    brave
    parsec-bin
    protonmail-desktop
    nixos-generators
    ansible
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
    nixd
    alejandra
    vscode
    sshpass
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
