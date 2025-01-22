{ config, lib, pkgs, ... }:

{
  imports = [
    ./drives.nix
    ./nvidia.nix
    ./pipewire.nix
    # sddm is declared in ./desktop/hypr/hypr.nix
    #./system/sddm.nix
    ./shell.nix
    ./bootloader/grub.nix
   #./system/bootloader/sysd.nix
  ];
}