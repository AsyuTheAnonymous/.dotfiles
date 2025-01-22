{ config, lib, pkgs, ... }:

{
  imports = [
    ./system/drives.nix
    ./system/nvidia.nix
    ./system/pipewire.nix
    # sddm is declared in ./desktop/hypr/hypr.nix
    #./system/sddm.nix
    ./system/shell.nix
    ./system/bootloader/grub.nix
   #./system/bootloader/sysd.nix
  ];
}