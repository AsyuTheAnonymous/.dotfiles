{pkgs, ...}: {
  imports = [
    ./../Common/common.nix
  ];
  # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;

  # Main packages for all my systems
  environment.systemPackages = with pkgs; [
    libreoffice
    # (pkgs.callPackage ./custom/msty {})
  ];
}
