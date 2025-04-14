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
    ./Hacking/tools.nix
    ./Browsers/brave.nix
    ./Flatpak/flatpak.nix
    ./Remote/Parsec/parsec.nix
    ./Mail/Proton/mail.nix
    ./Terminals/Ghostty/ghostty.nix
    ./Editor/Vscode/vscode.nix
  ];

  environment.systemPackages = with pkgs; [
    nixos-generators
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
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
