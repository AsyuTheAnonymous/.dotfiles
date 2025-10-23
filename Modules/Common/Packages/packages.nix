{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./Automation/automation.nix
    ./Recording/obs.nix
    # ./Optimization/Cleaner/auto.nix
    ./Optimization/Nix/nix.nix
    ./Helpers/nh.nix
    # ./Hacking/Bug-Bounty/bb.nix
    ./Browsers/libre.nix
    ./Flatpak/flatpak.nix
    #./Remote/Parsec/parsec.nix
    ./Mail/Proton/mail.nix
    ./Terminals/Ghostty/ghostty.nix
    ./Editors/Vscode/vscode.nix
    ./Notes/Obsidian/obsidian.nix
    # ./Browsers/firefox.nix
    # ./VPN/OVPN/openvpn.nix
    # ./Remote/Remmina/remmina.nix
    # ./VPN/Proton/proton.nix
    # ./AI/Stack/ai-framework.nix
  ];

  environment.systemPackages = with pkgs; [
    # vivaldi
    # sunshine
    # moonlight-qt
    wireguard-tools
    chromium
    nixos-generators
    gimp
    figma-linux
    xarchiver
    appflowy
    # webcord
    neofetch
    pavucontrol
    bottles
    localsend
    unzip
    unrar
    zip
    tree
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
    orca-slicer
    flashprint
  ];
  # Used in the custom package overrides
  # programs.firefox = {
  #   enable = true;
  # };
  programs.localsend.enable = true;
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  # programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [ stdenv.cc.cc zlib fuse3 icu nss openssl curl expat ];

  # Moonlight Streaming Service
  # services.sunshine = {
  #   enable = true;
  # };


}
