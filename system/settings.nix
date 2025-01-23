{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./drives/drives.nix
    ./gpu/nvidia.nix
    ./audio/pipewire.nix
    ./system/greeter/sddm.nix
    ./shell/zsh.nix
    ./ssh.nix
    ./bootloader/grub.nix
   #./system/bootloader/sysd.nix
  ];
}