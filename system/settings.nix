{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./drives.nix
    ./nvidia.nix
    ./pipewire.nix
    # sddm is declared in ./desktop/hypr/hypr.nix
    #./system/sddm.nix
    ./shell.nix
    ./ssh.nix
    ./bootloader/grub.nix
   #./system/bootloader/sysd.nix
  ];
}