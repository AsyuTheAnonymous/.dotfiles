{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./drives/drives.nix
    ./gpu/nvidia.nix
    ./audio/pipewire.nix
    ./greeter/sddm.nix
    ./shell/zsh.nix
    ./network/ssh.nix
    ./bootloader/grub.nix
    #./system/bootloader/sysd.nix
    ./auto.nix
  ];
}