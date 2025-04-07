{ config, lib, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        ansible
        sshpass
        jenkins
    ];
}