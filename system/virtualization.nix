{ config, lib, pkgs, ... }:

{
  # Enable virtualization
  virtualisation.libvirtd.enable = true;

}