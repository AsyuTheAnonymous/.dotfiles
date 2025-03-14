{ config, lib, pkgs, ... }: {
    
    users.users.asyu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "libvirtd" ];
    packages = with pkgs; [
    ];
  };
}