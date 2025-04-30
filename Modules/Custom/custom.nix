{ config, lib, pkgs, ... }: {
    imports = [
        ./ReconFTW/reconftw.nix
    ];
    services.reconftw = {
        enable = true;
    };
}