{pkgs, ...}: {
  imports = [
    ./hacking/eth.nix
    ./common.nix
    ./unstable/laptop.nix
    ./automation/automation.nix
  ];
  # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;

  # Main packages for all my systems
  environment.systemPackages = with pkgs; [
    libreoffice
    # (pkgs.callPackage ./custom/msty {})
  ];
}
