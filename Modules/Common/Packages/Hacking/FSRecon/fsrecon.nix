{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      fsrecon = self.callPackage ./Package/FSRecon-pkg.nix {};
    })
  ];

  environment.systemPackages = with pkgs; [
    fsrecon
  ];
}